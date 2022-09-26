# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # *
#                                                                                                                     #
# Projet:              preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN                                                   #
# Les contributeurs:   og & ZarTek-Creole                                                                             #
#                                                                                                                     #
# Fichier:             addpre.tcl                                                                                     #
# Fichier crée le:     25 September 2022 11:55:49                                                                     #
# Créateur du fichier: ZarTek-Creole (https://github.com/ZarTek-Creole)                                               #
#                                                                                                                     #
# Derniere modif le:   25 September 2022 11:55:49                                                                     #
# Modifier par:        ZarTek-Creole (https://github.com/ZarTek-Creole)                                               #
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

proc ::PREEDb0t::addpre:init { args } {
	if { [catch { package require PREEDb0t-SQL 2.0 }] } { 
		set MSG_ERROR "\[addpre.tcl - erreur\] le fichier connect.tcl doit être charger avant addpre.tcl"
		return -code error ${MSG_ERROR};
	}
	package provide PREEDb0t-FCT 2.0
}
::PREEDb0t::addpre:init

bind pub -|- !addpre ::PREEDb0t::addpre
proc ::PREEDb0t::addpre { nick uhost hand chan arg } {
	set A_Time     [clock seconds]
	set A_Name     [lindex ${arg} 0]
	set A_Section  [lindex ${arg} 1]
	set A_Grp      [lindex [split ${A_Name} -] end]
	if { ![channel get ${chan} p2add] } {
		set MSG_ERROR	[format "L'utilisateur %s à tenté un !addpre sur %s, mais le salon n'a pas les *flags* necéssaire." ${nick} ${chan}]
		putlog ${MSG_ERROR}
		return -code error ${MSG_ERROR};
	}
	if { ${A_Section} == "" } {
		set MSG_ERROR	[format "\002\0033(\00314ADDPRE\0033)\002\0037 Syntax * !addpre <nom.de.la.release> <section>"]
		puthelp "privmsg ${chan} :${MSG_ERROR}"
		return -code error ${MSG_ERROR};
	}
	set A_Sql       "INSERT IGNORE INTO ${::PREEDb0t::mysql_(table)} "
	append A_Sql    "( `${::PREEDb0t::db_(rlsname)}`, `${::PREEDb0t::db_(grp)}`, `${::PREEDb0t::db_(section)}`, `${::PREEDb0t::db_(ctime)}`, `${::PREEDb0t::db_(rlsstatus)}` ) ";
	append A_Sql    "VALUES ( '${A_Name}', '${A_Grp}', '${A_Section}', '${A_Time}', 'addpre' );";
	set A_Sqld 	    [::mysql::exec ${::PREEDb0t::mysql_(handle)} ${A_Sql}];
	putlog "L'exécution de la requête a retourné: ${A_Sqld} pour ${A_Name}"
	set SQL_INSERTID [::mysql::insertid ${::PREEDb0t::mysql_(handle)}]
	if {  ${SQL_INSERTID} != "" } {
		set A_IMSG		[format "\002\0033(\00314PRE\0033)\002\00315 %s\0033-\0037 La release %s à été ajouter par %s/%s (ID: %s)" ${A_Section} ${A_Name} ${chan} ${nick} ${SQL_INSERTID}]
		puthelp "privmsg ${::PREEDb0t::chan_(pred)} :${A_IMSG}"
		return -code ok ${A_IMSG};
	}
	return -code continue	[format "La release %s na pas été ajouter (déjà existante ?) par %s/%s" ${A_Name} ${chan} ${nick}]
}
