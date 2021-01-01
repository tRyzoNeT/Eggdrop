################################################################################
# PREEDb0t v1.1 coder par OG (2020)                                            #
################################################################################
set mysql_(user) "mysqld_user"
set mysql_(password) "mysqld_pass"
set mysql_(host) "mysqld.ip"
set mysql_(db) "mysqld_database"
set mysql_(table) "mysqld_table"
set mysql_(tp2p) "mysqld_table_p2p"
################################################################################
set db_(id) "id"
set db_(rlsname) "rlsname"
set db_(grp) "grp"
set db_(section) "section"
set db_(ctime) "ctime"
set db_(files) "files"
set db_(size) "size"
set db_(exact_info) "exact_info"
set db_(exact_size) "exact_size"
set db_(genre) "genre"
set db_(url) "lien_url"
set db_(m3uname) "m3uname"
set db_(nfoname) "nfoname"
set db_(nfosize) "nfosize"
set db_(sfvname) "sfvname"
set db_(sfvsize) "sfvsize"
set db_(nuke) "nuke"
set db_(nuke_ctime) "nuke_ctime"
set db_(nuke_reason) "nuke_reason"
set db_(nuke_net) "nuke_net"
set db_(moddelpre) "moddelpre"
set db_(moddelpre_ctime) "moddelpre_ctime"
set db_(moddelpre_reason) "moddelpre_reason"
set db_(moddelpre_net) "moddelpre_net"
set db_(modnuke) "modnuke"
set db_(modnuke_ctime) "modnuke_ctime"
set db_(modnuke_reason) "modnuke_reason"
set db_(modnuke_net) "modnuke_net"
set db_(modunnuke) "modunnuke"
set db_(modunnuke_ctime) "modunnuke_ctime"
set db_(modunnuke_reason) "modunnuke_reason"
set db_(modunnuke_net) "modunnuke_net"
set db_(unnuke) "unnuke"
set db_(unnuke_ctime) "unnuke_ctime"
set db_(unnuke_reason) "unnuke_reason"
set db_(unnuke_net) "unnuke_net"
set db_(delpre) "delpre"
set db_(delpre_ctime) "delpre_ctime"
set db_(delpre_reason) "delpre_reason"
set db_(delpre_net) "delpre_net"
set db_(undelpre) "undelpre"
set db_(undelpre_ctime) "undelpre_ctime"
set db_(undelpre_reason) "undelpre_reason"
set db_(undelpre_net) "undelpre_net"
set db_(rls_addpre) "rls_addpre"
set db_(rls_addpre_nick) "rls_addpre_nick"
set db_(rls_addpre_chan) "rls_addpre_chan"
set db_(rls_addpre_network) "rls_addpre_network"
set db_(rls_addpre_source) "rls_addpre_source"
set db_(rls_addold) "rls_addold"
set db_(rls_addold_nick) "rls_addold_nick"
set db_(rls_addold_chan) "rls_addold_chan"
set db_(rls_addold_netwok) "rls_addold_network"
set db_(rls_addold_source) "rls_addold_source"
set db_(rls_sitepre) "rls_sitepre"
set db_(rls_sitepre_nick) "rls_sitepre_nick"
set db_(rls_sitepre_chan) "rls_sitepre_chan"
set db_(rls_sitepre_netwok) "rls_sitepre_network"
set db_(rls_sitepre_source) "rls_sitepre_source"
set db_(rls_readd) "rls_readd"
set db_(rls_readd_nick) "rls_readd_nick"
set db_(rls_readd_chan) "rls_readd_chan"
set db_(rls_readd_network) "rls_readd_network"
set db_(rls_readd_source) "rls_readd_source"
################################################################################
setudef flag search
setudef flag db
setudef flag add
setudef flag stats
################################################################################
set chan_(add) "#chanADD"
set chan_(p2p) "#chanP2P"
set chan_(pred) "#chanPRED"
set chan_(nuke) "#chanNUKE"
################################################################################
load /X/libmysqltcl3.052.so
putlog "PREEDb0t v1.1 coder par OG (2020) chargé."
############################### END OF SCRIPT ##################################
