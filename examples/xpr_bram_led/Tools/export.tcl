############################################################################
# 06/24/08 - Story
#
# This proc will export the indicated project directory
############################################################################
proc export { imp_dir export_dir } {
   puts "\n**** Exporting $imp_dir to $export_dir ****"

   # create the export dir if it doesn't exist
   file mkdir $export_dir

   # delete the contents of the export dir
   set exp_files [glob -nocomplain -directory $export_dir *]
   if {[llength $exp_files] > 0} {
      eval file delete -force $exp_files
   }

   # get all the files/directories to be copied
   set imp_files [glob -directory $imp_dir *]

   # copy everything
   if {[catch {eval file copy -force $imp_files $export_dir } results] } {
      puts "ERROR: export failed for project $imp_dir - $results!"
      return 1
   }
   return 0
}
