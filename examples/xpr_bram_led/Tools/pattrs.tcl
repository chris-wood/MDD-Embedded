############################################################################
# pattrs.tcl
#   Partition Attributes processing.  This file contains utility functions for
# processing the partitions attributes list and the per-configuration attribute
# lists defined in the data.tcl file.
#
# $Header: /devl/xcs/repo/users/hdscripts/xpartition/pattrs.tcl,v 1.2 2009/06/22 20:38:59 kruse Exp $
############################################################################

########################################
# FindPartitionAttrs - find the attributes list for the given partition name.
# Return the results as a list of lists of name/value pairs.
########################################
proc FindPartitionAttrs { PartitionAttrsList name } {

  foreach item $PartitionAttrsList {
    if {[lindex $item 0] == $name} {
      return [lrange $item 1 end]
    }
  }
  return {}
}

########################################
# FindAttr
########################################
proc FindAttr {AttrPairsList attrName} {

  foreach pair $AttrPairsList {
    if {[lindex $pair 0] == $attrName} {
      return [lindex $pair 1]
    }
  }
  return ""
}

########################################
# GetPartitionAttrValue
########################################
proc GetPartitionAttrValue {PartitionAttrsList PartitionName Attr} {

  set attrslist [FindPartitionAttrs $PartitionAttrsList $PartitionName]

  set value [FindAttr $attrslist $Attr]

  return $value
}

########################################
# InsertPartitionAttrs
#    For the given partition name, find certain per-partition attributes and
# add them to the output file.  DRC the attr values at the same time.  If the
# attr is missing or has no value, nothing is written.
#    Attributes:
# Reconfigurable  [ true | false ]
# Isolated        [ true | false ]
########################################
proc InsertPartitionAttrs {PartitionAttrsList partitionName outStream} {

  upvar $outStream stream

  # We have a partition attributes list from the data.tcl file.  Look for 
  # certain attributes.

  # Reconfigurable
  set myVal [GetPartitionAttrValue $PartitionAttrsList $partitionName "Reconfigurable"]
  if {$myVal != ""} {

    # The attribute was defined.  DRC the value.
    if {$myVal == "true"} {
       puts -nonewline $stream " Reconfigurable=\"true\""
    } elseif {$myVal == "false"} {
       puts -nonewline $stream " Reconfigurable=\"false\""
    } else {
      puts "ERROR: Unsupported value for the \"Reconfigurable\" attribute on Partition ABC of \"$myVal\"."
      exit 2
    }
  }

  # Isolated
  set myVal [GetPartitionAttrValue $PartitionAttrsList $partitionName "Isolated"]
  if {$myVal != ""} {

    # The attribute was defined.  DRC the value.  
    if {$myVal == "true"} {
       puts -nonewline $stream " Isolated=\"true\""
    } elseif {$myVal == "false"} {
       puts -nonewline $stream " Isolated=\"false\""
    } else {
      puts "ERROR: Unsupported value for the \"Isolated\" attribute on Partition ABC of \"$myVal\"."
      exit 2
    }
  }
}

########################################
# InsertConfigAttrs
#    For the given partition name, find certain per-partition, per-config
# attributes and add them to the output file.  DRC the attr values at the same 
# time.  If the attr is missing or has no value, nothing is written.
#    Attributes:
# State  [ implement | import | export ]
# ImportLocation  <path>  // For now support "NONE" as a value
# Preserve  [ inherit | synthesis | placement | routing ]
# ModName   <name>
# 
########################################
proc InsertConfigAttrs {attrsList outStream} {

  upvar $outStream stream

  # State
  set value [FindAttr $attrsList "State"]
  if {$value == ""} {
    puts "ERROR: Missing or empty State attribute in config attributes."
    exit 2
  } elseif {$value == "implement" || $value == "import" || $value == "export"} {
     puts -nonewline $stream " State=\"$value\""
  } else {
    puts "ERROR: Bad value $value for State attribute in configuration."
    exit 2
  }

  # ImportLocation
  set value [FindAttr $attrsList "ImportLocation"]
  if {$value != "" && $value != "NONE"} {
    puts -nonewline $stream " ImportLocation=\"$value\""
  }

  # ImportTag
  set value [FindAttr $attrsList "ImportTag"]
  if {$value != "" && $value != "NONE"} {
    puts -nonewline $stream " ImportTag=\"$value\""
  }

  # ModName
  set value [FindAttr $attrsList "ModName"]
  if {$value != ""} {
    puts -nonewline $stream " ReconfigModuleName=\"$value\""
  }

  # Preserve
  set value [FindAttr $attrsList "Preserve"]
  if {$value != ""} {
    if {$value == "inherit" || $value == "synthesis" || $value == "placement" ||
        $value == "routing"} {
      puts -nonewline $stream " Preserve=\"$value\""
    } else {
      puts "ERROR: Bad value $value for Preserve attribute in configuration."
      exit 2
    }
  }
}

########################################
# GetConfigName
#   Given a configuration list, return the value of the ConfigName attribute.
########################################
proc GetConfigName { config } {

  # Get the ConfigName attr pair from the list
  foreach item $config {
    if {[lindex $item 0] == "ConfigName"} {
      return [lrange $item 1 end]
    }
  }
  return ""
}

########################################
# GetConfigAttrValue
#   Given a configuration list and a partition name, return the value of the
# given attribute (e.g. State).
########################################
proc GetConfigAttrValue {config PartitionName Attr} {

  # Find the Settings list within the configuration.
  set PartitionAttrsList {}
  foreach item $config {
    if {[lindex $item 0] == "Settings"} {
      set PartitionAttrsList [lrange $item 1 end]
      break
    }
  }
  
  set attrslist [FindPartitionAttrs $PartitionAttrsList $PartitionName]

  set value [FindAttr $attrslist $Attr]

  return $value
}

########################################
# GetRMsForConfig
#   Given a configuration list, build a list of netlist directories (without
# the path).
########################################
proc GetRMsForConfig {config} {

  set rmList {}
  
  # Find the Settings list within the configuration.
  set Partitions {}
  foreach item $config {
    if {[lindex $item 0] == "Settings"} {
      set Partitions [lrange $item 1 end]
      break
    }
  }

  if {[llength $Partitions] < 1} {
    puts "ERROR:  Missing \'Settings\' list in configuration."
    exit 2
  }

  foreach item $Partitions {
    set mod [FindAttr $item "NetlistDir"]
    if {$mod != ""} {
      lappend rmList $mod
    }
  }
  return $rmList
}
