#####################################################################################
#                 PREEDb0t v2.0 par OG (2022) projet via tRyzoNeT                   #
#####################################################################################
#   Remerciement à ZarTek de https://github.com/ZarTek-Creole pour son temps libre  #
#####################################################################################
namespace eval ::PREEDb0t {
	array set mysql_ [list 													\
		"user" 			"mysql.users"										\
		"password" 		"mot.de.pass"										\
		"host" 			"ip"										\
		"db" 			"mysql.database"									\
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
	if { [catch { package require mysqltcl }] } { die "\[preed.tcl - erreur\] le script PREEDb0t nécessite le package mysqltcl pour fonctionner. Le chargement du script a été annulé. pour l'installer : apt install mysqltcl" ; return }
	package provide PREEDb0t 2.0
	putlog "PREEDb0t v2.0 par OG (2022) chargé."
	############################### END OF SCRIPT ##################################
}
