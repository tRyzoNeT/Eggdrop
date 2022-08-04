################################################################################
#              PREEDb0t v2.0 par OG (2022) projet via tRyzoNeT                 #
################################################################################
#         Remerciement a ZarTek *Creole github* pour sont temps libres         #
################################################################################
namespace eval ::PREEDb0t {
	variable mysql_(user) 			"sql_user"
	variable mysql_(password) 		"sql_pass"
	variable mysql_(host) 			"sql_hostip"
	variable mysql_(db) 				"sql_database"
	variable mysql_(table) 			"sql_tabledb"
	################################################################################
	variable db_(id) 				"id"
	variable db_(rlsname) 			"rlsname"
	variable db_(grp) 				"grp"
	variable db_(section) 			"section"
	variable db_(ctime) 				"ctime"
	variable db_(files) 				"files"
	variable db_(size) 				"size"
	variable db_(exact_info) 		"exact_info"
	variable db_(exact_size) 		"exact_size"
	variable db_(genre) 				"genre"
	variable db_(url) 				"lien_url"
	variable db_(m3uname) 			"m3uname"
	variable db_(nfoname) 			"nfoname"
	variable db_(nfosize) 			"nfosize"
	variable db_(sfvname) 			"sfvname"
	variable db_(sfvsize) 			"sfvsize"
	variable db_(nuke) 				"nuke"
	variable db_(nuke_ctime) 		"nuke_ctime"
	variable db_(nuke_reason) 		"nuke_reason"
	variable db_(nuke_net) 			"nuke_net"
	variable db_(moddelpre) 			"moddelpre"
	variable db_(moddelpre_ctime) 	"moddelpre_ctime"
	variable db_(moddelpre_reason) 	"moddelpre_reason"
	variable db_(moddelpre_net) 		"moddelpre_net"
	variable db_(modnuke) 			"modnuke"
	variable db_(modnuke_ctime) 		"modnuke_ctime"
	variable db_(modnuke_reason) 	"modnuke_reason"
	variable db_(modnuke_net)		"modnuke_net"
	variable db_(modunnuke)			"modunnuke"
	variable db_(modunnuke_ctime)	"modunnuke_ctime"
	variable db_(modunnuke_reason)	"modunnuke_reason"
	variable db_(modunnuke_net)		"modunnuke_net"
	variable db_(unnuke)				"unnuke"
	variable db_(unnuke_ctime)		"unnuke_ctime"
	variable db_(unnuke_reason)		"unnuke_reason"
	variable db_(unnuke_net) 		"unnuke_net"
	variable db_(delpre) 			"delpre"
	variable db_(delpre_ctime) 		"delpre_ctime"
	variable db_(delpre_reason) 		"delpre_reason"
	variable db_(delpre_net) 		"delpre_net"
	variable db_(undelpre) 			"undelpre"
	variable db_(undelpre_ctime) 	"undelpre_ctime"
	variable db_(undelpre_reason) 	"undelpre_reason"
	variable db_(undelpre_net) 		"undelpre_net"
	variable db_(rls_addpre) 		"rls_addpre"
	variable db_(rls_addpre_nick)	"rls_addpre_nick"
	variable db_(rls_addpre_chan) 	"rls_addpre_chan"
	variable db_(rls_addpre_network) "rls_addpre_network"
	variable db_(rls_addpre_source) 	"rls_addpre_source"
	variable db_(rls_addold) 		"rls_addold"
	variable db_(rls_addold_nick) 	"rls_addold_nick"
	variable db_(rls_addold_chan) 	"rls_addold_chan"
	variable db_(rls_addold_netwok) 	"rls_addold_network"
	variable db_(rls_addold_source) 	"rls_addold_source"
	variable db_(rls_sitepre) 		"rls_sitepre"
	variable db_(rls_sitepre_nick) 	"rls_sitepre_nick"
	variable db_(rls_sitepre_chan) 	"rls_sitepre_chan"
	variable db_(rls_sitepre_netwok) "rls_sitepre_network"
	variable db_(rls_sitepre_source) "rls_sitepre_source"
	variable db_(rls_readd) 			"rls_readd"
	variable db_(rls_readd_nick) 	"rls_readd_nick"
	variable db_(rls_readd_chan)     "rls_readd_chan"
	variable db_(rls_readd_network)  "rls_readd_network"
	variable db_(rls_readd_source)   "rls_readd_source"
	################################################################################
	variableudef flag p2add
	variableudef flag p2nuker
	################################################################################
	variable chan_(add)				"#chan"
	variable chan_(pred)				"#chan"
	variable chan_(nuke)				"#chan"
	variable chan_(stats)			"#chan"
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