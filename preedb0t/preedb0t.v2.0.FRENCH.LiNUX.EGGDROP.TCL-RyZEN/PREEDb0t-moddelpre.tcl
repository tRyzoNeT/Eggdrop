# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # *
#                                                                                                                     # 
# Projet:              preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN                                                   # 
# Les contributeurs:   og & ZarTek-Creole                                                                             # 
#                                                                                                                     # 
# Fichier:             moddelpre.tcl                                                                                  # 
# Fichier crée le:     30 September 2022 16:29:00                                                                     # 
# Créateur du fichier: og                                                                                             # 
#                                                                                                                     # 
# Derniere modif le:   30 September 2022 16:29:00                                                                     # 
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

proc ::PREEDb0t::moddelpre:init { args } {
	if { [catch { package require PREEDb0t-SQL 2.0 }] } { 
		set MSG_ERROR "\[moddelpre.tcl - erreur\] le fichier mysql.tcl doit être charger avant moddelpre.tcl"
		return -code error ${MSG_ERROR};
	}
	package provide PREEDb0t-FCT 2.0
}
::PREEDb0t::moddelpre:init

bind pub -|- !moddelpre ::PREEDb0t::moddelpre
proc ::PREEDb0t::moddelpre { nick uhost hand chan arg } {
 set MD_Time   [clock seconds]
 set MD_Name   [lindex ${arg} 0]
 set MD_Raison [lindex ${arg} 1]
 set MD_Net    [lindex ${arg} 2]
 set MD_Grp    [lindex [split ${MD_Name} -] end]
 if { ![channel get ${chan} p2nuker] } {
  putlog "L'utilisateur ${nick} à tenté un !moddelpre sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
  return 0;
 }
 if { ${MD_Net} == "" } {
  putquick "privmsg ${chan} \002\0033(\00313MODdELPRE\0033)\002\0037 Syntax * !moddelpre <nom.de.la.release> <moddelpre.raison> <nukenet>"
  return 0;
 }
 set MD_Sql     "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( `${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, `${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, `${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` )";
 append MD_Sql  "VALUES ( '${MD_Name}', '${MD_Grp}', 'moddelpre', '${MD_Time}', '${MD_Raison}', '${MD_Net}' );";
 set MD_Sqld 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${MD_Sql}];
 putlog "L'exécution de la requête a retourné: ${MD_Sqld} pour ${MD_Name}"
 if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
  putlog "La release \002${MD_Name}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
 }
 set MD_SqlUP 		"UPDATE `${::PREEDb0t::mysql_(table)}` ";
 append MD_SqlUP 	"SET `${::PREEDb0t::db_(nuke_status)}`='moddelpre', `${::PREEDb0t::db_(nuke_ctime)}`='${MD_Time}', `${::PREEDb0t::db_(nuke_reason)}`='${MD_Raison}', `${::PREEDb0t::db_(nuke_net)}`='${MD_Net}' "
 append MD_SqlUP	"WHERE `${::PREEDb0t::db_(rlsname)}`='${MD_Name}';";
 set MD_SqldUP		[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${MD_SqlUP}];
 set MD_Sqldid1    "SELECT `${::PREEDb0t::db_(id)}` FROM `${::PREEDb0t::mysql_(table)}` WHERE `${::PREEDb0t::db_(rlsname)}` LIKE '${MD_Name}%'";
 set MD_Sqldid2    [::mysql::sel ${::PREEDb0t::mysql_(handle)} ${MD_Sqldid1} -flatlist];
 lassign  ${MD_Sqldid2} MD_Id;
 putlog "L'exécution de la requête a retourné: ${MD_Sqld} pour ${MD_Name}"
 if { ${MD_SqldUP} != "" } {
  putlog "La release \002${MD_Name}\002 à été MODDELPRE par ${chan}/${nick} (ID: ${MD_Id})";
  set MD_IMSG [format "\002\0033(\00313MODdELPRE\0033)\002\0037 ${MD_Name} \0033-\00315 ${MD_Raison} \0033(\00311${MD_Net}\0033)"]
  putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${MD_IMSG}"
 }
 return -1
}
