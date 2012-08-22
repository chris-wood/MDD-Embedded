############################################################################
# 06/04/08 - Story
#
# This script will create and/or modify the necessary XPartition files
# for each project
#
# $Header: /devl/xcs/repo/users/hdscripts/xpartition/gen_xp.tcl,v 1.2 2009/06/22 20:38:59 kruse Exp $
############################################################################

proc gen_xp { config PartitionAttrsList } {

   set configName [GetConfigName $config]

   puts "\n**** Generating XPartition file for $configName ****"

   set XPARTITION_FILE xpartition.pxml

   #------------------------------------------------------------------------
   # define the various components of the XPartition file
   set HEADER \
"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>
<!-- #TS# -->\n<!-- Produced by gen_xp.tcl for automated PR testing -->\n"

   set PROJECT_HEADER \
"<!-- Users may only modify the Project Name attribute below -->
<Project FileVersion=\"1.2\" Name=\"#PROJECT_NAME#\" ProjectVersion=\"2.0\">
"

   set PARTITION_END \
">
    </Partition>"

   set FILE_END \
"\n  </Partition>

</Project>"

   #------------------------------------------------------------------------

   # open the XPartition file to be written
   if {[catch {set outfile [open $XPARTITION_FILE "w"]} results]} {
      puts "ERROR: could not open XPartition file - $results!"
      return 2
   }

   # write the header data
   set ts [clock format [clock scan now] ]
   regsub #TS# $HEADER $ts data
   puts $outfile $data

   # substitute the project name in the project header and write it to the file
   regsub #PROJECT_NAME# $PROJECT_HEADER $configName data
   puts $outfile $data

   # Write out the top partition.  Assume the first partition in the list is it.
   set Partitions {}
   foreach item $config {
      if {[lindex $item 0] == "Settings"} {
         set Partitions [lrange $item 1 end]
         break
      }
   }

   set PartitionList [lindex $Partitions 0]
   WritePartitionLine $PartitionAttrsList $PartitionList outfile "  "
   puts $outfile ""

   for {set i 1} {$i < [llength $Partitions]} {incr i 1} {
      set PartitionList [lindex $Partitions $i]
      WritePartitionLine $PartitionAttrsList $PartitionList outfile "    "
      puts $outfile "    </Partition>"
   }

   # finally write the file tail and close
   puts $outfile $FILE_END
   close $outfile

   return 0
}

proc WritePartitionLine { PartitionAttrsList PartitionList outfile indent } {

   upvar $outfile stream

   set pName [lindex $PartitionList 0]
   puts -nonewline $stream "$indent<Partition Name=\"$pName\""

   # Insert the attributes that are common to all configurations for a given
   # partition.
   InsertPartitionAttrs $PartitionAttrsList $pName stream

   # Insert the attributes that might vary from config to config, for the given
   # partition.
   InsertConfigAttrs $PartitionList stream

   puts $stream ">"
}
