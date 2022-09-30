# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # *
#                                                                                                                     # 
# Projet:              preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN                                                   # 
# Les contributeurs:   og & ZarTek-Creole                                                                             # 
#                                                                                                                     # 
# Fichier:             delpre.tcl                                                                                     # 
# Fichier crée le:     30 September 2022 15:37:00                                                                     # 
# Créateur du fichier: og                                                                                             # 
#                                                                                                                     # 
# Derniere modif le:   30 September 2022 15:37:00                                                                     # 
# Modifier par:        og                                                                                             # 
#                                                                                                                     # 
# Site web: https://github.com/tRyzoNeT/Eggdrop/tree/master/preedb0t/preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN     # 
#                                                                                                                     # 
# HISTORY:                                                                                                            # 
# Date      	par		Commantaire                                                                                   # 
# ----------	---		---------------------------------------------------------                                     # 
#                                                                                                                     # 
# MIT License                                                                                                         # 
#                                                                                                                     # 
# Copyright (c) 2022 tRyzoNeT                                                                                         # 
#                                                                                                                     # 
# Permission is hereby granted, free of charge, to any person obtaining a copy of                                     # 
# this software and associated documentation files (the "Software"), to deal in                                       # 
# the Software without restriction, including without limitation the rights to                                        # 
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies                                       # 
# of the Software, and to permit persons to whom the Software is furnished to do                                      # 
# so, subject to the following conditions:                                                                            # 
#                                                                                                                     # 
# The above copyright notice and this permission notice shall be included in all                                      # 
# copies or substantial portions of the Software.                                                                     # 
#                                                                                                                     # 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR                                          # 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,                                            # 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE                                         # 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER                                              # 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,                                       # 
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE                                       # 
# SOFTWARE.                                                                                                           # 
#                                                                                                                     # 
# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # *

proc ::PREEDb0t::delpre:init { args } {
	if { [catch { package require PREEDb0t-SQL 2.0 }] } { 
		set MSG_ERROR "\[delpre.tcl - erreur\] le fichier mysql.tcl doit être charger avant delpre.tcl"
		return -code error ${MSG_ERROR};
	}
	package provide PREEDb0t-FCT 2.0
}
::PREEDb0t::delpre:init

bind pub -|- !delpre ::PREEDb0t::delpre
proc ::PREEDb0t::delpre { nick uhost hand chan arg } {
 set D_Time   [clock seconds]
 set D_Name   [lindex ${arg} 0]
 set D_Raison [lindex ${arg} 1]
 set D_Net    [lindex ${arg} 2]
 set D_Grp    [lindex [split ${D_Name} -] end]
 if { ![channel get ${chan} p2nuker] } {
  putlog "L'utilisateur ${nick} à tenté un !delpre sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
  return 0;
 }
 if { ${D_Net} == "" } {
  putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Syntax * !delpre <nom.de.la.release> <nuke.raison> <nukenet>"
  return 0;
 }
 set D_Sql      "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( `${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, `${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, `${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` ) ";
 append D_Sql   "VALUES ( '${D_Name}', '${D_Grp}', 'delpre', '${D_Time}', '${D_Raison}', '${D_Net}' );";
 set D_Sqld 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${D_Sql}];
 putlog "L'exécution de la requête a retourné: ${D_Sqld} pour ${D_Name}"
 if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
  putlog "La release \002${D_Name}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
 }
 set D_SqlUP      "UPDATE `${::PREEDb0t::mysql_(table)}` ";
 append D_SqlUP   "SET `${::PREEDb0t::db_(nuke_status)}`='nuke', `${::PREEDb0t::db_(nuke_ctime)}`='${D_Time}', `${::PREEDb0t::db_(nuke_reason)}`='${D_Raison}', `${::PREEDb0t::db_(nuke_net)}`='${D_Net}' ";
 append D_SqlUP   "WHERE `${::PREEDb0t::db_(rlsname)}`= '${D_Name}';";
 set D_SqldUP     [::mysql::exec ${::PREEDb0t::mysql_(handle)} ${D_SqlUP}];
 set D_Sqldid1    "SELECT `${::PREEDb0t::db_(id)}` FROM `${::PREEDb0t::mysql_(table)}` WHERE `${::PREEDb0t::db_(rlsname)}` LIKE '${D_Name}%'";
 set D_Sqldid2    [::mysql::sel ${::PREEDb0t::mysql_(handle)} ${D_Sqldid1} -flatlist];
 lassign  ${D_Sqldid2} D_Id;
 putlog "L'exécution de la requête a retourné: ${D_SqldUP} pour ${D_Name}";
 if { ${D_SqldUP} != "" } {
  putlog "La release \002${D_Name}\002 à été DELPRE par ${chan}/${nick} (ID: ${D_Id})";
  set D_IMSG [format "\002\0033(\00314DELPRE\0033)\002\0037 ${D_Name} \0033-\00315 ${D_Raison} \0033(\00311${D_Net}\0033)"]
  putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${D_IMSG}"
 }
 return -1
}
