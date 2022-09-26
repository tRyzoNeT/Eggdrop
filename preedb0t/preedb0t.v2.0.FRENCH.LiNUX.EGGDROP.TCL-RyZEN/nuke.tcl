if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[nuke.tcl - erreur\] le fichier connect.tcl doit être charger avant nuke.tcl" ; return }
bind pub -|- !nuke ::PREEDb0t::nuke
proc ::PREEDb0t::nuke { nick uhost hand chan arg } {
	set N_Time   [clock seconds]
	set N_Name   [lindex ${arg} 0]
	set N_Raison [lindex ${arg} 1]
	set N_Net    [lindex ${arg} 2]
	set N_Grp    [lindex [split ${N_Name} -] end]
	if { ![channel get ${chan} p2nuker] } {
		putlog "L'utilisateur ${nick} à tenté un !nuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
		return 0;
	}
	if { ${N_Net} == "" } {
		putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Syntax * !nuke <nom.de.la.release> <nuke.raison> <nukenet>"
		return 0;
	}
	set N_Sql      "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( `${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, `${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, `${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` ) ";
	append N_Sql   "VALUES ( '${N_Name}', '${N_Grp}', 'nuke', '${N_Time}', '${N_Raison}', '${N_Net}' );";
	set N_Sqld 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${N_Sql}];
	putlog "L'exécution de la requête a retourné: ${N_Sqld} pour ${N_Name}"
	if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } {
		putlog "La release \002${N_Name}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
	}
	set N_SqlUP      "UPDATE `${::PREEDb0t::mysql_(table)}` ";
	append N_SqlUP   "SET `${::PREEDb0t::db_(nuke_status)}`='nuke', `${::PREEDb0t::db_(nuke_ctime)}`='${N_Time}', `${::PREEDb0t::db_(nuke_reason)}`='${N_Raison}', `${::PREEDb0t::db_(nuke_net)}`='${N_Net}' ";
	append N_SqlUP   "WHERE `${::PREEDb0t::db_(rlsname)}`= '${N_Name}';";
	set N_SqldUP     [::mysql::exec ${::PREEDb0t::mysql_(handle)} ${N_SqlUP}];
	set N_Sqldid1    "SELECT `${::PREEDb0t::db_(id)}` FROM `${::PREEDb0t::mysql_(table)}` WHERE `${::PREEDb0t::db_(rlsname)}` LIKE '${N_Name}%'";
	set N_Sqldid2    [::mysql::sel ${::PREEDb0t::mysql_(handle)} ${N_Sqldid1} -flatlist];
	lassign  ${N_Sqldid2} N_Id;
	putlog "L'exécution de la requête a retourné: ${N_SqldUP} pour ${N_Name}";
	if { ${N_SqldUP} != "" } {
		putlog "La release \002${N_Name}\002 à été NUKE par ${chan}/${nick} (ID: ${N_Id})";
		set N_IMSG [format "\002\0033(\0034NUKE\0033)\002\0037 ${N_Name} \0033-\00315 ${N_Raison} \0033(\00311${N_Net}\0033)"]
		putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${N_IMSG}"
	}
	return -1
}
