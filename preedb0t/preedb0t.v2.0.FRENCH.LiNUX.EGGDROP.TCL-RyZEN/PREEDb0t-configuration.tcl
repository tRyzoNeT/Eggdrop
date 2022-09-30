# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # *
#                                                                                                                     # 
# Projet:              preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN                                                   # 
# Les contributeurs:   og & ZarTek-Creole                                                                             # 
#                                                                                                                     # 
# Fichier:             configuration.tcl                                                                              # 
# Fichier crée le:     24 September 2022 8:20:12                                                                      # 
# Créateur du fichier: ZarTek-Creole (https://github.com/ZarTek-Creole)                                               # 
#                                                                                                                     # 
# Derniere modif le:   30 September 2022 13:40:12                                                                     # 
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

namespace eval ::PREEDb0t {
	array set mysql_ [list 													\
		"user" 			"andy_p2users"										\
		"password" 		"vA%oqOqyZ7._"										\
		"host" 			"216.219.81.80"										\
		"db" 			"andy_preedb0t20"									\
		"table" 		"maindb"											\
		"tablenuke" 	"nukedb"											\
		];
	################################################################################
	array set db_ [list														\
		"id" 					"id"										\
		"rlsname" 				"rlsname"									\
		"grp" 					"grp"										\
		"section" 				"section"									\
		"ctime" 				"ctime"										\
		"files" 				"files"										\
		"size" 					"size"										\
		"exact_info" 			"exact_info"								\
		"exact_size" 			"exact_size"								\
		"genre" 				"genre"										\
		"url" 					"lien_url"									\
		"m3uname" 				"m3uname"									\
		"nfoname" 				"nfoname"									\
		"nfosize" 				"nfosize"									\
		"sfvname" 				"sfvname"									\
		"sfvsize" 				"sfvsize"									\
		"nuke_status" 			"nuke_status"								\
		"nuke_ctime" 			"nuke_ctime"								\
		"nuke_reason" 			"nuke_reason"								\
		"nuke_net" 				"nuke_net"									\
		"rlsstatus"	 			"status"									\
		];
	array set nuke_ [list													\
		"id" 					"id"										\
		"rlsname" 				"rlsname"									\
		"grp" 					"grp"										\
		"status"	 			"status"									\
		"ctime" 				"ctime"										\
		"reason"	 			"reason"									\
		"nukenet" 				"nukenet"									\
		];
	################################################################################
	setudef flag p2add
	setudef flag p2nuker
	setudef flag p2db
	setudef flag p2stats
	setudef flag p2search
	################################################################################
	array set chan_ [list													\
		"add"					"#chan"									\
		"pred"					"#chan"									\
		"nuke"					"#chan"									\
		"stats"					"#chan"									\
		];
	################################################################################
	# Note de ZarTeK:
	# Il est plus simple d'installer mysqltcl de nos jours, sous debian/ubuntu
	# 	apt install mysqltcl
	# Pour charger sufis de faire ceci:
	#load /usr/lib64/tcl8.5/mysqltcl-3.052/libmysqltcl3.052.so
	if { [catch { package require mysqltcl }] } { die "\[configuration.tcl - erreur\] le script PREEDb0t nécessite le package mysqltcl pour fonctionner. Le chargement du script a été annulé. pour l'installer : apt install mysqltcl" ; return }
	package provide PREEDb0t 2.0
	putlog "PREEDb0t v2.0 - contributeurs og & ZarTek-Creole (2022) chargé."
	############################### END OF SCRIPT ##################################
}
