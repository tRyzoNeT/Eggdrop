if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[modnuke.tcl - erreur\] le fichier connect.tcl doit être charger avant modnuke.tcl" ; return }
bind pub -|- !modnuke ::PREEDb0t::modnuke
proc ::PREEDb0t::modnuke { nick uhost hand chan arg } {
	set modnuke_(time)     [clock seconds]
	set chan            [string tolower ${chan}]
	set modnuke_(release)  [lindex ${arg} 0]
	set modnuke_(raison)   [lindex ${arg} 1]
	set modnuke_(net)  [lindex ${arg} 2]
	set modnuke_(group)    [lindex [split ${modnuke_(release)} -] end]
	if { ![channel get ${chan} p2nuker] } {
		putlog "L'utilisateur ${nick} à tenté un !modnuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
		return 0;
	}
	if { ${modnuke_(net)} == "" } {
		putquick "privmsg ${chan} \002\0033(\0035MODNUKE\0033)\002\0037 Syntax * !modnuke <nom.de.la.release> <nuke.raison> <nukenet>"
		return 0;
	}
    set SQL_INSERT          "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` "
    append SQL_INSERT       ") VALUES ( "
    append SQL_INSERT           "'${modnuke_(release)}', '${modnuke_(group)}', "
    append SQL_INSERT           "'modnuke', '${modnuke_(time)}', "
    append SQL_INSERT           "'${modnuke_(raison)}', '${modnuke_(net)}' "
    append SQL_INSERT       ");"
    set SQL_RESULTAT 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_INSERT}];
	putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${modnuke_(release)}"
    if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
		putlog "La release \002${modnuke_(release)}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
	}
	set SQL_UPDATE 		"UPDATE `${::PREEDb0t::mysql_(table)}` SET "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_status)}`		= 'modnuke', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_ctime)}`		= '${modnuke_(time)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_reason)}` 	= '${modnuke_(raison)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_net)}` 	= '${modnuke_(net)}' "
	append SQL_UPDATE	"WHERE `${::PREEDb0t::db_(rlsname)}` 	= '${modnuke_(release)}'";
	set SQL_ID			[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_UPDATE}];
	putlog "L'exécution de la requête a retourné: ${SQL_ID} pour ${modnuke_(release)}"
	if { ${SQL_ID} != "" } {
		putlog "La release \002${modnuke_(release)}\002 à été MODNUKE par ${chan}/${nick} (ID: XxX)";
		set IRC_MSG [format "\002\0033(\0035MODNUKE\0033)\002\0037 ${modnuke_(raison)} ${modnuke_(net)} ${modnuke_(release)}"]
		putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${IRC_MSG}"
	}
	#
	return -1
}
