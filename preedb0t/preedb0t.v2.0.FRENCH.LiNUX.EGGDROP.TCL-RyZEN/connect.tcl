# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # *
#                                                                                                                     # 
# Projet:              preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN                                                   # 
# Les contributeurs:   og & ZarTek-Creole                                                                             # 
#                                                                                                                     # 
# Fichier:             connect.tcl                                                                                    # 
# Fichier crée le:     7 September 2022 9:31:31                                                                       # 
# Créateur du fichier: ZarTek-Creole (https://github.com/ZarTek-Creole)                                               # 
#                                                                                                                     # 
# Derniere modif le:   7 September 2022 9:31:31                                                                       # 
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



if { [catch { package require PREEDb0t 2.0 }] } { die "\[preed.tcl - erreur\] le fichier preed.tcl doit être charger en premier dans votre fichier eggdrop.conf" ; return }

proc ::PREEDb0t::MySQL:KeepAlive {} {
	if { ![info exists ::PREEDb0t::mysql_(handle)] || [mysql::state ${::PREEDb0t::mysql_(handle)} -numeric] == 0 || ![mysql::ping ${::PREEDb0t::mysql_(handle)}] } {
		if { [catch { set ::PREEDb0t::mysql_(handle) [::mysql::connect -multistatement 1 -host ${::PREEDb0t::mysql_(host)} -user ${::PREEDb0t::mysql_(user)} -password ${::PREEDb0t::mysql_(password)} -db ${::PREEDb0t::mysql_(db)}] } MYSQL_ERR] } {
			if { [string match "*Access*denied*" ${MYSQL_ERR}] } {
				die "PREEDb0t: Verifier les informations MySQL"
			}
			die "SQL FATAL ERROR (::mysql::connect): ${MYSQL_ERR}"
		}
	}
    putlog "PREEDb0t: (mySQLd) (Re)Connexion au serveur mysqld avec success: ${::PREEDb0t::mysql_(handle)}"
	utimer 120 [list ::PREEDb0t::MySQL:KeepAlive]
	return 0
}
::PREEDb0t::MySQL:KeepAlive 
package provide PREEDb0t-SQL 2.0
