if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[addpre.tcl - erreur\] le fichier connect.tcl doit être charger avant addpre.tcl" ; return }
bind pub -|- !addpre ::PREEDb0t::addpre
proc ::PREEDb0t::addpre { nick uhost hand chan arg } {
	set A_Time     [clock seconds]
	set A_Name     [lindex ${arg} 0]
	set A_Section  [lindex ${arg} 1]
	set A_Grp      [lindex [split ${A_Name} -] end]
	if { ![channel get ${chan} p2add] } {
		putlog "L'utilisateur ${nick} à tenté un !addpre sur ${chan}, mais le salon n'a pas les *flags* necéssaire."
		return 0;
	}
	if { ${A_Section} == "" } {
		set A_IMSG [format "\002\0033(\00314ADDPRE\0033)\002\0037 Syntax * !addpre <nom.de.la.release> <section>"]
		putquick "privmsg ${chan} :${A_IMSG}"
		return 0;
	}
	set A_Sql       "INSERT IGNORE INTO ${::PREEDb0t::mysql_(table)} ( `${::PREEDb0t::db_(rlsname)}`, `${::PREEDb0t::db_(grp)}`, `${::PREEDb0t::db_(section)}`, `${::PREEDb0t::db_(ctime)}`, `${::PREEDb0t::db_(rlsstatus)}` ) ";
	append A_Sql    "VALUES ( '${A_Name}', '${A_Grp}', '${A_Section}', '${A_Time}', 'addpre' );";
	set A_Sqld 	    [::mysql::exec ${::PREEDb0t::mysql_(handle)} ${A_Sql}];
	putlog "L'exécution de la requête a retourné: ${A_Sqld} pour ${A_Name}"
	if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } {
		putlog "La release ${A_Name} à été ajouter par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
		set A_IMSG [format "\002\0033(\00314PRE\0033)\002\00315 ${A_Section} \0033-\0037 ${A_Name}"]
		putquick "privmsg ${::PREEDb0t::chan_(pred)} :${A_IMSG}"
	}
	return -1
}
