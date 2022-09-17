if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[unnuke.tcl - erreur\] le fichier connect.tcl doit être charger avant nunuke.tcl" ; return }
bind pub -|- !unnuke ::PREEDb0t::unnuke
proc ::PREEDb0t::unnuke { nick uhost hand chan arg } {
	set unnuke_(time)     [clock seconds]
	set chan            [string tolower ${chan}]
	set unnuke_(release)  [lindex ${arg} 0]
	set unnuke_(raison)   [lindex ${arg} 1]
	set unnuke_(net)  [lindex ${arg} 2]
	set unnuke_(group)    [lindex [split ${unnuke_(release)} -] end]
	if { ![channel get ${chan} p2nuker] } {
		putlog "L'utilisateur ${nick} à tenté un !unnuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
		return 0;
	}
	if { ${unnuke_(net)} == "" } {
		putquick "privmsg ${chan} \002\0033(UNNUKE)\002\0037 Syntax * !unnuke <nom.de.la.release> <unnuke.raison> <nukenet>"
		return 0;
	}
    set SQL_INSERT          "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` "
    append SQL_INSERT       ") VALUES ( "
    append SQL_INSERT           "'${unnuke_(release)}', '${unnuke_(group)}', "
    append SQL_INSERT           "'unnuke', '${unnuke_(time)}', "
    append SQL_INSERT           "'${unnuke_(raison)}', '${unnuke_(net)}' "
    append SQL_INSERT       ");"
    set SQL_RESULTAT 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_INSERT}];
	putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${unnuke_(release)}"
    if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
		putlog "La release \002${unnuke_(release)}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
	}
	set SQL_UPDATE 		"UPDATE `${::PREEDb0t::mysql_(table)}` SET "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_status)}`		= 'unnuke', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_ctime)}`		= '${unnuke_(time)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_reason)}` 	= '${unnuke_(raison)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_net)}` 	= '${unnuke_(net)}' "
	append SQL_UPDATE	"WHERE `${::PREEDb0t::db_(rlsname)}` 	= '${unnuke_(release)}'";
	set SQL_ID			[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_UPDATE}];
	putlog "L'exécution de la requête a retourné: ${SQL_ID} pour ${unnuke_(release)}"
	if { ${SQL_ID} != "" } {
		putlog "La release \002${unnuke_(release)}\002 à été UNNUKE par ${chan}/${nick} (ID: XxX)";
		set IRC_MSG [format "\002\0033(UNNUKE)\002\0037 ${unnuke_(raison)} ${unnuke_(net)} ${unnuke_(release)}"]
		putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${IRC_MSG}"
	}
	#
	return -1
}
