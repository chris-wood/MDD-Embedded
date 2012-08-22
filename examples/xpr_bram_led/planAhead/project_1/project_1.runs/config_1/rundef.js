//
// PlanAhead(TM)
// rundef.js: a PlanAhead-generated ExploreAhead Script for WSH 5.1/5.6
// Copyright 1986-1999, 2001-2010 Xilinx, Inc. All Rights Reserved.
//

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\lib\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\lib\\nt64;";
} else {
  PathVal = "H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\lib\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\lib\\nt64;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


ISEStep( "ngdbuild",
         "-intstyle ise -p xc6vlx240tff1156-1 -sd \"C:\\Users\\Sam\\Downloads\\xpr_chris_project\\xpr_bram_led\\planAhead\\project_1\\project_1.srcs\\sources_1\\imports\" -uc \"config_1.ucf\" \"config_1.edf\"" );
ISEStep( "map",
         "-intstyle ise -w \"config_1.ngd\"" );
ISEStep( "par",
         "-intstyle ise \"config_1.ncd\" -w \"config_1_routed.ncd\"" );
ISEStep( "trce",
         "-intstyle ise -o \"config_1.twr\" -v 30 -l 30 \"config_1_routed.ncd\" \"config_1.pcf\"" );
ISEStep( "xdl",
         "-secure -ncd2xdl -nopips \"config_1_routed.ncd\" \"config_1_routed.xdl\"" );



function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
