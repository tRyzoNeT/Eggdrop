if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[nuke.tcl - erreur\] le fichier connect.tcl doit être charger avant nuke.tcl" ; return }
bind pub -|- !nuke ::PREEDb0t::nuke
proc ::PREEDb0t::nuke { nick uhost hand chan arg } {
	set nuke_(time)     [clock seconds]
	set chan            [string tolower ${chan}]
	set nuke_(release)  [lindex ${arg} 0]
	set nuke_(raison)   [lindex ${arg} 1]
	set nuke_(net)      [lindex ${arg} 2]
	if { ![channel get ${chan} p2nuker] } {
		putlog "L'utilisateur ${nick} à tenté un !nuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
		return 0;
	}
	# Note de ZarTek :
	# si nuke_(net) est manquant, forcement ce n'ai pas bon, pas besoin de verifier addpre_(section), addpre_(section), addpre_(release)
	# ATTENTION : dans addpre.tcl nuke_(net) s'apelle addpre(source),
	# il est recommander de nommer tous source, ou tous net, mais pas une fois l'un puis l'autre pour respecter une logique
	if { ${nuke_(net)} == "" } {
		putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Syntax * !nuke <nom.de.la.release> <nuke.raison> <nukenet>"
		return 0;
	}
	# Note de ZarTek :
	# Si par exemple la rlsname est delpre, et ensuite nuke, le status delpre sera remis a 0 je ne suis pas sur que ce comportement est souhaité?
	set SQL_UPDATE 		"UPDATE `${::PREEDb0t::mysql_(table)}` SET "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(delpre)}`			= '0' , "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(moddelpre)}`		= '0', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(modnuke)}`			= '0', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(modunnuke)}`		= '0', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(unnuke)}`			= '0', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(undelpre)}`			= '0', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke)}` 			= '1', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_ctime)}`		= '${nuke_(time)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_reason)}` 		= '${nuke_(raison)}', "
	append SQL_UPDATE 		"`${::PREEDb0t::db_(nuke_net)}` 		= '${nuke_(net)}', "
	append SQL_UPDATE 		"(SELECT @update_id := id) "
	append SQL_UPDATE	"WHERE `${::PREEDb0t::db_(rlsname)}` 		= '${nuke_(release)}';"
	set SQL_ID			[::mysql::exec ${::PREEDb0t::mysql_(handle)} "SET @update_id := 0; ${SQL_UPDATE} SELECT @update_id;"];
	putlog "L'exécution de la requête a retourné: ${SQL_ID} pour ${nuke_(release)}"
	if { ${SQL_ID} != "" } {
		putlog "La release \002${nuke_(release)}\002 à été NUKE par ${chan}/${nick} (ID: ${SQL_ID})";
		set IRC_MSG [format "\002\0033(\0034NUKE\0033)\002\0037 (%s - %s)\0030 %s" ${nuke_(raison)} ${nuke_(net)} ${nuke_(release)}]
		putquick "privmsg ${chan_(nuke)} :${IRC_MSG}"
	}
	return -1
}
