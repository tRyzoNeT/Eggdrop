if { [catch { package require PREEDb0t 2.0 }] } { die "\[preed.tcl - erreur\] le fichier preed.tcl doit être charger en premier dans votre fichier eggdrop.conf" ; return }
bind pub -|- !nuke ms:nuke
proc ms:nuke { nick uhost hand chan arg } {
    set nuke_(time)     [clock seconds]
    set chan            [string tolower ${chan}]
    if { ![channel get ${chan} p2nuker] } {
        putlog "L'utilisateur ${nick} à tenté un !nuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
        return 0;
    }
    if { ${arg} == "" } {
        putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Syntax * !nuke <nom.de.la.release> <nuke.raison> <nukenet>"
        return 0;
    }
    set nuke_(release)  [lindex ${arg} 0]
    set nuke_(raison)   [lindex ${arg} 1]
    set nuke_(net)      [lindex ${arg} 2]
    # Note de ZarTeK:
    # Toujours commencer avec les 'if' qui aurons le plus de chance d'arriver
	if { ${nuke_(net)} == "" } {
		putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Erreur * NUKENET du nuke MANQUANT";
		return 0
	}
	if { ${nuke_(raison)} == "" } {
		putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Erreur * RAiSON du nuke MANQUANT";
		return 0;
	}
    if { ${nuke_(release)} == "" } {
        putquick "privmsg ${chan} \002\0033(\0034NUKE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANTE";
        return 0;
    }


    global network prefix_ mysql_ db_ chan_
    set group 			[lindex [split ${nuke_(release)} -] end]
    set SQL_UPDATE 		"UPDATE $mysql_(table) SET "
    append SQL_UPDATE 	"$db_(delpre)='0', $db_(moddelpre)='0', $db_(modnuke)='0', $db_(modunnuke)='0', $db_(unnuke)='0', $db_(undelpre)='0', "
    append SQL_UPDATE 	"$db_(nuke)='1', $db_(nuke_ctime)='$nuke_(time)', $db_(nuke_reason)='$nuke_(raison)', $db_(nuke_net)='$nuke_(net)' "
    append SQL_UPDATE	"WHERE $db_(rlsname)='$nuke_(release)'"
    set SQL_RESULTAT	[::mysql::exec ${mysql_(handle)} ${SQL_UPDATE}];
    putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${nuke_(release)}"
    if { [::mysql::insertid ${mysql_(handle)}] != "" } {
        putlog "La release \002${nuke_(release)}\002 à été NUKE par ${chan}/${nick} (ID: [::mysql::insertid ${mysql_(handle)}])";
        putquick "privmsg ${chan_(nuke)} \002\0033(\0034NUKE\0033)\002\0037 (${nuke_(raison)} - ${nuke_(net)})\0030 ${nuke_(release)}"
    }
    return -1
}
