#####################################################################################
#                 PREEDb0t v2.0 par OG (2022) projet via tRyzoNeT                   #
#####################################################################################
#   Remerciement à ZarTek de https://github.com/ZarTek-Creole pour son temps libre  #
#####################################################################################
namespace eval ::PREEDb0t {
	array set mysql_ [list 													\
		"user" 			"sql_user"											\
		"password" 		"sql_pass"											\
		"host" 			"sql_hostip"										\
		"db" 			"sql_database"										\
		"table" 		"sql_tabledb"										\
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
		"nuke" 					"nuke"										\
		"nuke_ctime" 			"nuke_ctime"								\
		"nuke_reason" 			"nuke_reason"								\
		"nuke_net" 				"nuke_net"									\
		"moddelpre" 			"moddelpre"									\
		"moddelpre_ctime" 		"moddelpre_ctime"							\
		"moddelpre_reason" 		"moddelpre_reason"							\
		"moddelpre_net" 		"moddelpre_net"								\
		"modnuke" 				"modnuke"									\
		"modnuke_ctime" 		"modnuke_ctime"								\
		"modnuke_reason" 		"modnuke_reason"							\
		"modnuke_net"			"modnuke_net"								\
		"modunnuke"				"modunnuke"									\
		"modunnuke_ctime"		"modunnuke_ctime"							\
		"modunnuke_reason"		"modunnuke_reason"							\
		"modunnuke_net"			"modunnuke_net"								\
		"unnuke"				"unnuke"									\
		"unnuke_ctime"			"unnuke_ctime"								\
		"unnuke_reason"			"unnuke_reason"								\
		"unnuke_net" 			"unnuke_net"								\
		"delpre" 				"delpre"									\
		"delpre_ctime" 			"delpre_ctime"								\
		"delpre_reason" 		"delpre_reason"								\
		"delpre_net" 			"delpre_net"								\
		"undelpre" 				"undelpre"									\
		"undelpre_ctime" 		"undelpre_ctime"							\
		"undelpre_reason" 		"undelpre_reason"							\
		"undelpre_net" 			"undelpre_net"								\
		"rls_addpre" 			"rls_addpre"								\
		"rls_addpre_nick"		"rls_addpre_nick"							\
		"rls_addpre_chan" 		"rls_addpre_chan"							\
		"rls_addpre_network" 	"rls_addpre_network"						\
		"rls_addpre_source" 	"rls_addpre_source"							\
		"rls_addold" 			"rls_addold"								\
		"rls_addold_nick" 		"rls_addold_nick"							\
		"rls_addold_chan" 		"rls_addold_chan"							\
		"rls_addold_netwok" 	"rls_addold_network"						\
		"rls_addold_source" 	"rls_addold_source"							\
		"rls_sitepre" 			"rls_sitepre"								\
		"rls_sitepre_nick" 		"rls_sitepre_nick"							\
		"rls_sitepre_chan" 		"rls_sitepre_chan"							\
		"rls_sitepre_netwok" 	"rls_sitepre_network"						\
		"rls_sitepre_source" 	"rls_sitepre_source"						\
		"rls_readd" 			"rls_readd"									\
		"rls_readd_nick" 		"rls_readd_nick"							\
		"rls_readd_chan"     	"rls_readd_chan"							\
		"rls_readd_network"  	"rls_readd_network"							\
		"rls_readd_source"   	"rls_readd_source"							\
	];
	################################################################################
	setudef flag p2add
	setudef flag p2nuker
	################################################################################
	array set chan_ [list													\
		"add"					"#chan"										\
		"pred"					"#chan"										\
		"nuke"					"#chan"										\
		"stats"					"#chan"										\
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