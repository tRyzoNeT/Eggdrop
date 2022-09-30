# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # *
#                                                                                                                     # 
# Projet:              preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN                                                   # 
# Les contributeurs:   og & ZarTek-Creole                                                                             # 
#                                                                                                                     # 
# Fichier:             modnuke.tcl                                                                                    # 
# Fichier crée le:     25 September 2022 11:55:49                                                                     # 
# Créateur du fichier: ZarTek-Creole (https://github.com/ZarTek-Creole)                                               # 
#                                                                                                                     # 
# Derniere modif le:   30 September 2022 15:31:00                                                                     # 
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

proc ::PREEDb0t::modnuke:init { args } {
	if { [catch { package require PREEDb0t-SQL 2.0 }] } { 
		set MSG_ERROR "\[modnuke.tcl - erreur\] le fichier mysql.tcl doit être charger avant modnuke.tcl"
		return -code error ${MSG_ERROR};
	}
	package provide PREEDb0t-FCT 2.0
}
::PREEDb0t::modnuke:init

bind pub -|- !modnuke ::PREEDb0t::modnuke
proc ::PREEDb0t::modnuke { nick uhost hand chan arg } {
	set MN_Time   [clock seconds]
	set MN_Name   [lindex ${arg} 0]
	set MN_Raison [lindex ${arg} 1]
	set MN_Net    [lindex ${arg} 2]
	set MN_Grp    [lindex [split ${MN_Name} -] end]
	if { ![channel get ${chan} p2nuker] } {
		putlog "L'utilisateur ${nick} à tenté un !modnuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
		return 0;
	}
	if { ${MN_Net} == "" } {
		putquick "privmsg ${chan} \002\0033(\0035MODNUKE\0033)\002\0037 Syntax * !modnuke <nom.de.la.release> <modnuke.raison> <nukenet>"
		return 0;
	}
	set MN_Sql     "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( `${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, `${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, `${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` )";
	append MN_Sql  "VALUES ( '${MN_Name}', '${MN_Grp}', 'modnuke', '${MN_Time}', '${MN_Raison}', '${MN_Net}' );";
	set MN_Sqld 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${MN_Sql}];
	putlog "L'exécution de la requête a retourné: ${MN_Sqld} pour ${MN_Name}"
	if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } {
		putlog "La release \002${MN_Name}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
	}
	set MN_SqlUP 		"UPDATE `${::PREEDb0t::mysql_(table)}` ";
	append MN_SqlUP 	"SET `${::PREEDb0t::db_(nuke_status)}`='modnuke', `${::PREEDb0t::db_(nuke_ctime)}`='${MN_Time}', `${::PREEDb0t::db_(nuke_reason)}`='${MN_Raison}', `${::PREEDb0t::db_(nuke_net)}`='${MN_Net}' "
	append MN_SqlUP	"WHERE `${::PREEDb0t::db_(rlsname)}`='${MN_Name}';";
	set MN_SqldUP		[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${MN_SqlUP}];
	set MN_Sqldid1    "SELECT `${::PREEDb0t::db_(id)}` FROM `${::PREEDb0t::mysql_(table)}` WHERE `${::PREEDb0t::db_(rlsname)}` LIKE '${MN_Name}%'";
	set MN_Sqldid2    [::mysql::sel ${::PREEDb0t::mysql_(handle)} ${MN_Sqldid1} -flatlist];
	lassign  ${MN_Sqldid2} MN_Id;
	putlog "L'exécution de la requête a retourné: ${MN_Sqld} pour ${MN_Name}"
	if { ${MN_SqldUP} != "" } {
		putlog "La release \002${MN_Name}\002 à été MODNUKE par ${chan}/${nick} (ID: ${MN_Id})";
		set MN_IMSG [format "\002\0033(\0035MODNUKE\0033)\002\0037 ${MN_Name} \0033-\00315 ${MN_Raison} \0033(\00311${MN_Net}\0033)"]
		putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${MN_IMSG}"
	}
	return -1
}
