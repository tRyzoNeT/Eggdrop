if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[modunnuke.tcl - erreur\] le fichier connect.tcl doit être charger avant modunnuke.tcl" ; return }
bind pub -|- !modunnuke ::PREEDb0t::modunnuke
proc ::PREEDb0t::modunnuke { nick uhost hand chan arg } {
	set modunnuke_(time)     [clock seconds]
	set chan            [string tolower ${chan}]
	set modunnuke_(release)  [lindex ${arg} 0]
	set modunnuke_(raison)   [lindex ${arg} 1]
	set modunnuke_(net)  [lindex ${arg} 2]
	set modunnuke_(group)    [lindex [split ${modunnuke_(release)} -] end]
	if { ![channel get ${chan} p2nuker] } {
		putlog "L'utilisateur ${nick} à tenté un !modunnuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
		return 0;
	}
	if { ${modunnuke_(net)} == "" } {
		putquick "privmsg ${chan} \002\0033(\00355MODUNNUKE\0033)\002\0037 Syntax * !modunnuke <nom.de.la.release> <nuke.raison> <nukenet>"
		return 0;
	}
    set SQL_INSERT          "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, "
    append SQL_INSERT          "`${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` "
    append SQL_INSERT       ") VALUES ( "
    append SQL_INSERT           "'${modunnuke_(release)}', '${modunnuke_(group)}', "
    append SQL_INSERT           "'modunnuke', '${modunnuke_(time)}', "
    append SQL_INSERT           "'${modunnuke_(raison)}', '${modunnuke_(net)}' "
    append SQL_INSERT       ");"
    set SQL_RESULTAT 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_INSERT}];
	putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${modunnuke_(release)}"
    if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
		putlog "La release \002${modunnuke_(release)}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
	}
	set SQL_UPDATE 		"UPDATE `${::PREEDb0t::mysql_(table)}` SET "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_status)}`		= 'modunnuke', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_ctime)}`		= '${modunnuke_(time)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_reason)}` 	= '${modunnuke_(raison)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_net)}` 	= '${modunnuke_(net)}' "
	append SQL_UPDATE	"WHERE `${::PREEDb0t::db_(rlsname)}` 	= '${modunnuke_(release)}'";
	set SQL_ID			[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_UPDATE}];
	putlog "L'exécution de la requête a retourné: ${SQL_ID} pour ${modunnuke_(release)}"
	if { ${SQL_ID} != "" } {
		putlog "La release \002${modunnuke_(release)}\002 à été MODUNNUKE par ${chan}/${nick} (ID: XxX)";
		set IRC_MSG [format "\002\0033(\00355MODUNNUKE\0033)\002\0037 ${modunnuke_(raison)} ${modunnuke_(net)} ${modunnuke_(release)}"]
		putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${IRC_MSG}"
	}
	#
	return -1
}
