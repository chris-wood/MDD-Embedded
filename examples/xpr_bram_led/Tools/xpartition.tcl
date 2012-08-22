############################################################################
# This script will define and implement an XPartition PR (or NPR) design 
#
# 06/04/08 - Story, Initial version
# 06/24/08 - Story, Separate design specific data from implementation script
############################################################################


set debug 0; # Set from 0 to 4 for more verbose modes
if {$debug >= 1} {
   puts "DEBUG: Debug mode is set to $debug. Verbose modes are from 1 to 4"
}

#--------------------------------------------------------------------------
# point to the design specific data for this test 
set DATA_DIR ../tcl
set DATA_FILE ${DATA_DIR}/data.tcl
set synthDir Synth
set implDir Implementation

# see if the data file was specified on the command line
if { 1 == $argc } {
   set DATA_FILE [lindex $argv 0]
   puts "Overriding with data file $DATA_FILE"
}

if {! [file exists $DATA_FILE] } {
   puts "ERROR: Could not find data file $DATA_FILE"
   exit 1;
}

# now source the design specific data
source $DATA_FILE
#--------------------------------------------------------------------------

# save the current working directory
set origDir [pwd]

# extract the path to the Tcl scripts
set this_script [info script]
set TCL_DIR [file dirname $this_script]

# source the scripts that generate XPartition file, implement, and export
source $TCL_DIR/gen_xp.tcl
source $TCL_DIR/implement.tcl
source $TCL_DIR/export.tcl
source $TCL_DIR/pattrs.tcl

# define external proc names
set IMPLEMENT implement
set EXPORT export


# see if there is any design specific implementation data.
# implementation data is used to customize the implementation of the design.
# it is set in the designs data.tcl file.
# it may contain the following data:
#
# RUN_RM_SYNTH=NO if the design has no modules to be synthesized bottom-up
# RUN_CFG_SYNTH=NO if the design does not need synthesis for each cfgs
# NGDBUILD_TOP=<top_path> is path to pre-existing top module for Ngdbuild
# NGDBUILD_SEARCH=<search_path ...> a string containing search path directories
# NGDBUILD_OPTS=<ngdbuild_command_line_options> optional command line options for Ngdbuild
# RUN_MAP=NO if you do not want to run Map
# MAP_OPTS=<map_command_line_options> optional command line options for Map
# RUN_PAR=NO if you do not want to run PAR
# PAR_OPTS=<par_command_line_options> optional command line options for Par
# RUN_BITGEN=NO if you do not want to generate bitstreams
# BITGEN_OPTS=<bitgen_command_line_options> optional command line options for Bitgen

if {! [array exists IMPLEMENTATION_DATA] } {
   array set IMPLEMENTATION_DATA {}
}

# check flag for whether bottom-up synthesis is required
set RUN_RM_SYNTH [lindex [array get IMPLEMENTATION_DATA RUN_RM_SYNTH] 1]

# check flag for whether we generate runfiles
set GENERATE_RUNFILES [lindex [array get IMPLEMENTATION_DATA GENERATE_RUNFILES] 1]

if {$RUN_RM_SYNTH != "NO"} {

   # set the synthesis tool
   set SYNTH_TOOL [lindex [array get IMPLEMENTATION_DATA SYNTH_TOOL] 1]   
   if {$SYNTH_TOOL == ""} {
      puts "Setting default synthesis tool to xst"
      set SYNTH_TOOL "xst"
   } else {
      puts "Synthesis tool is set to $SYNTH_TOOL"
   }

   # Synthesize each of the RMs first
   foreach rm $RMs {
      puts "**** Synthesizing Reconfig Module named <$rm> ****"
      cd $synthDir/$rm
      if {$debug >= 1} {
        set PWD [pwd]
        puts "DEBUG: pwd = $PWD"
      }
      # create the runfile for this module
      if {$GENERATE_RUNFILES == "YES"} {
         set runfile [open runfile.local "w"]
         puts $runfile "# source runfile.local "
      }

      # set up the command line
      if {$SYNTH_TOOL == "xst"} {
         set XST_DIR xst/xst.tmp
         file mkdir $XST_DIR
         set SYNTH_CMD "xst -ifn $rm.xst"
      } else {
         if {$SYNTH_TOOL == "synplify_pro"} {
            set SYNTH_CMD "synplify_pro -batch $rm.prj"
         } else {
            puts "Unrecognized SYNTH_TOOL $SYNTH_TOOL!"
            return 1
         }
      }

      puts $SYNTH_CMD

      # if there is a local xpartition.pxml, make sure it can be written to
      if [file exists "xpartition.pxml"] {
         puts "Local xpartition.pxml file found.  Making it writable on $tcl_platform(os)."
         if {$tcl_platform(os) == "Linux"} {
            file attributes xpartition.pxml -permissions 00666
         } elseif {$tcl_platform(os) == "Windows NT"} {
            file attributes xpartition.pxml -readonly 0
         } else {
            puts "Unsupported Platform $tcl_platform(os)"
            return 1
         }
      }

      if {$GENERATE_RUNFILES == "YES"} {
         puts $runfile $SYNTH_CMD
      } else {
 
      # run synthesis 
      if {[catch { eval exec $SYNTH_CMD } results] } {
         puts "ERROR: failed to synthesize $rm - $results!"
         cd $origDir
         exit 1;
      }
      }

      # close the runfile for this module
      if {$GENERATE_RUNFILES == "YES"} {
         close $runfile
      }
      cd $origDir
   }

   puts "\n**** Finished bottom-up synthesis of all RMs ****"

}


# now we're ready to implement the configurations!
# implement each of the configurations and generate bitstreams
if {$ALL_CFGS == ""} {
   puts "ERROR: \$ALL_CFGS has not been defined in your data.tcl"
   exit 2
} 
if {$debug >= 1} {
   puts "DEBUG: \$ALL_CFGS = $ALL_CFGS"
}

foreach config $ALL_CFGS {  
   if {$debug >= 1} {
      puts "DEBUG: Process configuration $config..."
   }
   set configName [GetConfigName $config]
   set configDir $implDir/$configName
   set exportDir $implDir/X$configName
   #if {$configName == ""} {
   #   puts "ERROR: ConfigName is not defined in the data.tcl for configuration \n   $config"
   #   exit 2
   #}
   if {$debug >= 1} {
      puts "DEBUG: Process config <$configName>..."
   }
   if { [file isdirectory $configDir] } {
      cd $configDir
      if {$debug >= 2} {
        puts "DEBUG: cd to $configDir..."
      }
      # build the RM list for this configuration
      set NETLISTDIRS [GetRMsForConfig $config]
      if {$debug >= 2} {
         puts "DEBUG:   NETLISTDIRS are: $NETLISTDIRS"
      }
      # create the XPartition file
      if {$debug >= 1} {
         puts "DEBUG:   Create xpartition.pxml file for config named $configName..."
      }
      set rc [gen_xp $config $PartitionAttrsList]
      if { $rc != 0 } {
         puts "ERROR: failed to generate XPartition file for $configName!"
         cd $origDir
         exit 2
      }

      # run the implementation script
      if {[$IMPLEMENT $tcl_platform(os) $PART $UCF $NETLISTDIRS \
           [array get IMPLEMENTATION_DATA] ] != 0 } {
         puts "ERROR: implementation failed for $configName!"
         cd $origDir
         exit 3
      }

      cd $origDir

      # Export implemented project so it may be imported in later configurations
      if {$GENERATE_RUNFILES != "YES"} {
         if {[$EXPORT $configDir $exportDir] != 0} {
            exit 4
         }
      }
   } else {
      puts "ERROR: Unable to find configuration directory $configDir. You must create this directory."
   }

}


# all done!
exit 0
