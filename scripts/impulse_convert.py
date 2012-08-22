#******************************************************************************
#
# File:    impulse_convert.py
# Author:  Christopher Wood, caw4567@rit.edu
# Author:  Robert LiVolsi, rjl3050@rit.edu
# Version: $Id: impulse_convert.py 39 2012-02-25 17:13:50Z w463-01u3f $
#
#******************************************************************************

# Library includes
import sys, string, os, subprocess, shutil, random

PROTOTYPE_SIGNATURE = "extern void"
HEADER_ADDENDUM = "// Appended process prototypes from ImpulseC translation script."
START = "#pragma START_TIME"
END = "#pragma END_TIME"

# The main entry point which parses command line arguments and kicks off translation
def main(args):
	if (len(args) != 4):
		print "Usage: python impulse_convert.py swfile.c hwfile.c interface.h"
	else:
		print "Input software module:  " + args[1]
		print "Input hardware module:  " + args[2]
		print "Input module interface: " + args[3]
		
		# Store the cmd line arguments
		sw = args[1]
		hw = args[2]
		head = args[3]

		# Open handles to the files
		hwFile = open(hw, 'r')
		swFile = open(sw, 'r')
		headerFile = open(head, 'r')

		# Fetch file contents
		hwContents = hwFile.read()
		hwFile.close()
		swContents = swFile.read()
		swFile.close()
		
		# Find each index
		print ""
		print "Determining processes."
		print ""
		origHwContents = hwContents
		functionTypes = list()
		index = hwContents.find(PROTOTYPE_SIGNATURE) # replace with constant
		while (index >= 0):
			endIndex = hwContents.find(';',index)
			print hwContents[index:endIndex]
			functionTypes.append(hwContents[index:endIndex])
			hwContents = hwContents[endIndex:]
			index = hwContents.find(PROTOTYPE_SIGNATURE) # replace with constant
		
		# Add these prototypes to the header file (assuming they aren't there already)
		headerContents = headerFile.read()
		headerFile.close()
		headerFile = open(head, 'a')
	
		# Don't duplicate text during the append process!
		if (not (headerContents.find(HEADER_ADDENDUM) >= 0)):
			headerFile.write(HEADER_ADDENDUM + "\n")
		for ptype in functionTypes:
			if (not (headerContents.find(ptype) >= 0)):
				headerFile.write(ptype + ";\n")

		# Strip out the filler to determiner the function names
		print ""
		print "Parsing the functions that were found."
		functions = dict()
		functionParams = dict()
		for ptype in functionTypes:
			print ""
			print "Parsing: " + ptype
			index = ptype.index(' ', 0) # skip extern
			index = ptype.index(' ', index + 1) # skip return (void)
			endIndex = ptype.index('(', index) # bound the name
			print "Function name: " + ptype[index:endIndex].lstrip().rstrip()
			functions[ptype[index:endIndex].lstrip().rstrip()] = ptype # add to the dictionary
			functionName = ptype[index:endIndex].lstrip().rstrip()

			# Now parse the parameter(s) to the function (streams, registers, signals, etc.)
			doneWithParams = False
			index = endIndex + 1
			paramList = ptype
			pList = list()
			while not doneWithParams:
				# Isolate the parameters one by one by parsing the string
				print paramList[2:]
				tmp = paramList.find(',', index + 2)
				if (tmp < 0):
					tmp = paramList.find(')', index + 2)
					doneWithParams = True
				endIndex = tmp
				
				# Check to make sure we don't declare these parameters n>1 times
				pList.append(paramList[index:endIndex].lstrip().rstrip())
				if (not (headerContents.find(paramList[index:endIndex] + ";") >= 0)):
					headerFile.write(paramList[index:endIndex] + ";\n")
 				
				# Go through the loop again
				index = endIndex + 1

			# Generate structure definition for them to use
			print "Parameter structure wrapper:"
			print ""
			print "typedef struct \n{"
			for param in pList:
				print "    " + param + ";"
			print "} " + functionName + "Params;"
			functionParams[functionName.lstrip().rstrip()] = functionName + "Params"

		# Generate the POSIX thread create code
		print ""
		print "Generating POSIX thread creation templates."
		print "Note that the last parameter (NULL) will need to be manually replaced when integrated into the Xilinx SDK."
		print ""
		processNum = 0
		for fName in functions.keys():
			processName = "id" + str(processNum)
			processNum = processNum + 1
			print "pthread_t " + str(processName) + ";"
			print functionParams[fName] + " params; // CONFIGURE MANUALLY!"
			print "pthread_create(&" + processName + ", NULL, (void*)" + fName + ", &params);"
			print ""
		
		# Search for start pragmas
		index = swContents.find(START)
		while (index > 0):
			startIndex = swContents[index:].find('(')
			endIndex = swContents[index:].find(')')
			param = swContents[index+startIndex + 1:index + endIndex]
			swContents = swContents.replace(swContents[index:index + endIndex + 1], 
											"TIMER_INIT(timer);\nSTART_TIME(timer," + param + ");")
			index = swContents[index + 1:].find(START)

		# Search for end pragmas
		index = swContents.find(END)
		while (index > 0):
			startIndex = swContents[index:].find('(')
			endIndex = swContents[index:].find(')')
			param = swContents[index+startIndex + 1:index + endIndex]
			swContents = swContents.replace(swContents[index:index + endIndex + 1], "END_TIME(timer," + param + ");")
			index = swContents[index + 1:].find(END)

		# Inform user about update and print code that needs to be added
		swFile = open(sw, 'w')
		swFile.write(swContents)
		print "Software file update - you need to add the following code for each INIT_TIMER macro:"
		print "  #include \"ProfileLibrary.h\""
		print "  XTmrCtr timer;"
		print ""

		# Display the remaining integration steps
		print "Remaining steps:"
		print "  1. Remove redundant main method in " + sw
		print "  2. Include pthread creation function calls into the main routine"
		print "  3. Include the Impulse C libraries into the SDK build path"

# Run it all
main(sys.argv)
