############################################################################
# 06/04/08 - Story
#
# This script will implement a XPartition PR configuration.  It is called
# from the xpartition.tcl script.
#
# This general purpose script should work in any PR configuration directory
# that follows the naming rules imposed by the xpartition.tcl script.
############################################################################
proc implement {PLATFORM PART UCF RM_LIST IMPLEMENTATION_DATA_LIST} {

   # use the current directory as the configuration name (i.e., from directory
   # /tmp/PRProject /FastConfig we will extract the configuration name 
   # "FastConfig"
   set cwd [pwd]
   set CONFIG [file tail $cwd]

   puts "\n**** Implementing $CONFIG ****"


   # write the current time
   puts "     Current time is: [clock format [clock scan now] ]"


   # get the flags from $IMPLEMENTATION_DATA for which applications need to run
   # and how to run them.
   # The format of this array is: 
   # RUN_RM_SYNTH=NO if the design has no modules to be synthesized bottom-up
   # RUN_CFG_SYNTH=NO if the design does not need synthesis for each cfgs
   # RUN_NGDBUILD=NO if you do not want to run Ngdbuild 
   # NGDBUILD_TOP=<top_path> is path to pre-existing top module for Ngdbuild
   # NGDBUILD_SEARCH=<search_path ...> a string containing search path 
   #                 directories
   # NGDBUILD_OPTS=<ngdbuild_command_line_options> optional command line options
   #               for Ngdbuild
   # RUN_MAP=NO if you do not want to run Map
   # MAP_OPTS=<map_command_line_options> optional command line options for Map
   # RUN_PAR=NO if you do not want to run PAR
   # PAR_OPTS=<par_command_line_options> optional command line options for Par
   # RUN_BITGEN=NO if you do not want to generate bitstreams
   # BITGEN_OPTS=<bitgen_command_line_options> optional command line options 
   #             for Bitgen
   array set IMPLEMENTATION_DATA $IMPLEMENTATION_DATA_LIST
   set RUN_CFG_SYNTH [lindex [array get IMPLEMENTATION_DATA RUN_CFG_SYNTH] 1]
   set RUN_NGDBUILD [lindex [array get IMPLEMENTATION_DATA RUN_NGDBUILD] 1]
   set NGDBUILD_TOP [lindex [array get IMPLEMENTATION_DATA NGDBUILD_TOP] 1]
   set NGDBUILD_SEARCH \
       [lindex [array get IMPLEMENTATION_DATA NGDBUILD_SEARCH] 1]
   set NGDBUILD_OPTS [lindex [array get IMPLEMENTATION_DATA NGDBUILD_OPTS] 1]
   set RUN_MAP [lindex [array get IMPLEMENTATION_DATA RUN_MAP] 1]
   set MAP_OPTS [lindex [array get IMPLEMENTATION_DATA MAP_OPTS] 1]
   set RUN_PAR [lindex [array get IMPLEMENTATION_DATA RUN_PAR] 1]
   set PAR_OPTS [lindex [array get IMPLEMENTATION_DATA PAR_OPTS] 1]
   set RUN_BITGEN [lindex [array get IMPLEMENTATION_DATA RUN_BITGEN] 1]
   set BITGEN_OPTS [lindex [array get IMPLEMENTATION_DATA BITGEN_OPTS] 1]
   set SYNTH_TOOL [lindex [array get IMPLEMENTATION_DATA SYNTH_TOOL] 1]
   set GENERATE_RUNFILES [lindex [array get IMPLEMENTATION_DATA GENERATE_RUNFILES] 1]

   if {$SYNTH_TOOL == ""} {
      puts "Setting default synthesis tool to xst"
      set SYNTH_TOOL "xst"
   }
   set DESIGN [lindex [array get IMPLEMENTATION_DATA DESIGN] 1]
   if {$DESIGN != ""} {
      puts "\nUsing design name $DESIGN"
      set CONFIG $DESIGN
   }

   # create a runfile for this config
   if {$GENERATE_RUNFILES == "YES"} {
      set runfile [open runfile.local "w"]
      puts $runfile "# source runfile.local "
   }

   #--XST START-------------------------------------------------------------
   if {$RUN_CFG_SYNTH != "NO"} {

      if {$SYNTH_TOOL == "xst"} {
         # create a work directory for Xst
         set XST_DIR xst/xst.tmp
         file mkdir $XST_DIR
         set SYNTH_CMD "xst -ifn [glob *.xst]"
      } else {
         if {$SYNTH_TOOL == "synplify_pro"} {
            set SYNTH_CMD "synplify_pro -batch [glob *.prj]"
            # Was erroring out for PR flows.
            #puts "Top down synthesis is not supported with synplify_pro"
            #return 1
         } else {
            puts "Unrecognized SYNTH_TOOL $SYNTH_TOOL!"
            return 1
         }
      }
      # run Synthesis 
      puts $SYNTH_CMD

      # if there is a local xpartition.pxml, make sure it can be written to
      if [file exists "xpartition.pxml"] {
         puts "Local xpartition.pxml file found.  Making it writable on $PLATFORM."
         if {$PLATFORM == "Linux"} {
            file attributes xpartition.pxml -permissions 00666
         } elseif {$PLATFORM == "Windows NT"} {
            file attributes xpartition.pxml -readonly 0
         } else {
            puts "Unsupported Platform $PLATFORM"   
            return 1
         }
      }
      if {$GENERATE_RUNFILES == "YES"} {
         puts $runfile $SYNTH_CMD 
      } else {
         if {[catch { eval exec $SYNTH_CMD } results] } {
            puts "ERROR: synthesis failed for $CONFIG - $results!"
            return 1
         }
      }
   }
   #--XST END---------------------------------------------------------------


   #--NGDBUILD START--------------------------------------------------------
   # construct the Ngdbuild search path arguments from the passed-in RM list
   set SD_LIST ""
   foreach RM $RM_LIST {
      if { $RM != "" && $RM != "NONE" } {
         set SD_LIST "${SD_LIST} -sd ../${RM}"
      }
   }

   # now add any explicitly specified search paths
   set SP_ITEMS [concat $NGDBUILD_SEARCH]
   foreach SP $SP_ITEMS {
      if { $SP != "" } {
         set SD_LIST "${SD_LIST} -sd ${SP}"
      }
   }

   # check for proper NGC file
   set TOP_MOD ""

   # check if design set the path to the top module
   if {$NGDBUILD_TOP != ""} {
      # design set the path to the top module - use that 
      set TOP_MOD $NGDBUILD_TOP
   } else {
      if { [file exists ${CONFIG}.ngc] } {
         set TOP_MOD ${CONFIG}.ngc
      } else {
         # no NGC file.  check for other input source file types
	 set EDF [glob -nocomplain *.edf]
         if { $EDF != "" } {
            # local edif file means that this design uses edif instead of NGC
            set TOP_MOD $EDF
         } else {
            set TOP_NGC top.ngc
            if { [file exists $TOP_NGC] } {
               set TOP_MOD $TOP_NGC
            }
         }
      }
   }

   # check that we found a top module for Ngdbuild
   if { ! [file exists $TOP_MOD] } {
      if {$GENERATE_RUNFILES == "YES"} {
         puts "WARNING: Failed to find Ngdbuild top module $TOP_MOD."
         puts "Make sure this module is synthesized before implementing the design." 
      } else { 
         puts "ERROR: Failed to find Ngdbuild top module $TOP_MOD!"
         puts "       Do you need to set \$NGDBUILD_TOP?"
         return 3
      }
   }

   # look for local UCF.  this allows each configuration to have its own
   # unique UCF by simply putting it in the configuration directory
   set LOCAL_UCF [glob -nocomplain *.ucf]
   if { $LOCAL_UCF != "" } {
      if { [llength $LOCAL_UCF] > 1 } {
         puts "ERROR: More than one UCF file found in directory ${CONFIG}!"
         return 4
      }

      # set the UCF to the local UCF
      set UCF $LOCAL_UCF
   }

   #--NGDBUILD START-------------------------------------------------------
   if {$RUN_NGDBUILD != "NO"} {
      # run Ngdbuild
      set NGDBUILD_CMD "ngdbuild ${NGDBUILD_OPTS} ${SD_LIST} -p ${PART} -uc ${UCF} ${TOP_MOD} ${CONFIG}.ngd"

      puts $NGDBUILD_CMD
      if {$GENERATE_RUNFILES == "YES"} {
         puts $runfile $NGDBUILD_CMD
      } else {
         if {[catch { eval exec $NGDBUILD_CMD } results] } {
            puts "ERROR: Ngdbuild failed for $CONFIG - $results!"
            return 1
         }
      }
   }
   #--NGDBUILD END----------------------------------------------------------



   #--MAP START-------------------------------------------------------------
   if {$RUN_MAP != "NO"} {
      # run Map
      set MAP_CMD "map ${MAP_OPTS} -w -o ${CONFIG}_map.ncd ${CONFIG}.ngd ${CONFIG}.pcf"
      puts $MAP_CMD
      if {$GENERATE_RUNFILES == "YES"} {
         puts $runfile $MAP_CMD
      } else {
         if {[catch { eval exec $MAP_CMD } results] } {
            puts "ERROR: MAP failed for $CONFIG - $results!"
            return 1
         }
         # Sanity check.  If map exits with a good status make sure we have an 
         # NCD.
         if {[file exists ${CONFIG}_map.ncd] != 1} {
            puts "ERROR: Scripting error!  MAP exited with a zero status but no NCD exists.  MAP failed for $CONFIG - $results!"
            return 1;
         }
      }
   }
   #--MAP END---------------------------------------------------------------



   #--PAR START-------------------------------------------------------------
   if {$RUN_PAR != "NO"} {
      # run Par
      set PAR_CMD "par ${PAR_OPTS} -w ${CONFIG}_map.ncd ${CONFIG}.ncd ${CONFIG}.pcf"
      puts $PAR_CMD
      if {$GENERATE_RUNFILES == "YES"} {
         puts $runfile $PAR_CMD
      } else {
         if {[catch { eval exec $PAR_CMD } results] } {
            puts "ERROR: Par failed for $CONFIG - $results!"
            return 1
         }
      }
   }
   #--PAR END---------------------------------------------------------------



   #--DRC START-------------------------------------------------------------
   # run DRC
   set DRC_CMD "drc ${CONFIG}.ncd ${CONFIG}.pcf"
##   puts $DRC_CMD
##   if {[catch { eval exec $DRC_CMD } results] } {
##      puts "ERROR: DRC failed for $CONFIG - $results!"
##      return 1
##   }
   #--DRC END---------------------------------------------------------------



   #--BITGEN START----------------------------------------------------------
   if {$RUN_BITGEN != "NO"} {
      # run bitgen
      set BITGEN_CMD "bitgen ${BITGEN_OPTS} -w ${CONFIG}.ncd"
      puts $BITGEN_CMD
      if {$GENERATE_RUNFILES == "YES"} {
         puts $runfile $BITGEN_CMD
      } else {
         if {[catch { eval exec $BITGEN_CMD } results] } {
            puts "ERROR: Bitgen failed for $CONFIG - $results!"
            return 1
         }
   
         # check that the bitstream was generated
         if {$BITGEN_OPTS != "-j"} {
            if {[file exists ${CONFIG}.bit] != 1} {
               puts "ERROR: failed to generate ${CONFIG} bitstream!"
               return 2;
            }
         }
      }
   }
   #--BITGEN END------------------------------------------------------------


   # write the current time
   puts "     Current time is: [clock format [clock scan now] ]"


   # close the runfile
   if {$GENERATE_RUNFILES == "YES"} {
      close $runfile
   }
   return 0
}
