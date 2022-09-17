if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[nuke.tcl - erreur\] le fichier connect.tcl doit être charger avant nuke.tcl" ; return }
bind pub -|- !nuke ::PREEDb0t::nuke
proc ::PREEDb0t::nuke { nick uhost hand chan arg } {
	set nuke_(time)     [clock seconds]
	set chan            [string tolower ${chan}]
	set nuke_(release)  [lindex ${arg} 0]
	set nuke_(raison)   [lindex ${arg} 1]
	set nuke_(net)  [lindex ${arg} 2]
	set nuke_(group)    [lindex [split ${nuke_(release)} -] end]
	if { ![channel get ${chan} p2nuker] } {
		putlog "L'utilisateur ${nick} à tenté un !nuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
		return 0;
	}
	if { ${nuke_(net)} == "" } {
		putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Syntax * !nuke <nom.de.la.release> <nuke.raison> <nukenet>"
		return 0;
	}
    set SQL_INSERT          "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` "
    append SQL_INSERT       ") VALUES ( "
    append SQL_INSERT           "'${nuke_(release)}', '${nuke_(group)}', "
    append SQL_INSERT           "'nuke', '${nuke_(time)}', "
    append SQL_INSERT           "'${nuke_(raison)}', '${nuke_(net)}' "
    append SQL_INSERT       ");"
    set SQL_RESULTAT 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_INSERT}];
	putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${nuke_(release)}"
    if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
		putlog "La release \002${nuke_(release)}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
	}
	set SQL_UPDATE 		"UPDATE `${::PREEDb0t::mysql_(table)}` SET "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_status)}`		= 'nuke', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_ctime)}`		= '${nuke_(time)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_reason)}` 	= '${nuke_(raison)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_net)}` 	= '${nuke_(net)}' "
	append SQL_UPDATE	"WHERE `${::PREEDb0t::db_(rlsname)}` 	= '${nuke_(release)}'";
	set SQL_ID			[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_UPDATE}];
	putlog "L'exécution de la requête a retourné: ${SQL_ID} pour ${nuke_(release)}"
	if { ${SQL_ID} != "" } {
		putlog "La release \002${nuke_(release)}\002 à été NUKE par ${chan}/${nick} (ID: XxX)";
		set IRC_MSG [format "\002\0033(\0034NUKE\0033)\002\0037 ${nuke_(raison)} ${nuke_(net)} ${nuke_(release)}"]
		putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${IRC_MSG}"
	}
	#
	return -1
}
