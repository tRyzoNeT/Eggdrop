if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[addpre.tcl - erreur\] le fichier connect.tcl doit être charger avant addpre.tcl" ; return }
bind pub -|- !addpre ::PREEDb0t::addpre
proc ::PREEDb0t::addpre { nick uhost hand chan arg } {
    set addpre_(time)       [clock seconds]
    set chan                [string tolower ${chan}]
    set addpre_(release)    [lindex ${arg} 0]
    set addpre_(section)    [lindex ${arg} 1]
    set addpre_(source)     [lindex ${arg} 2]
    set addpre_(group)      [lindex [split ${addpre_(release)} -] end]
    if { ![channel get ${chan} p2add] } {
        putlog "L'utilisateur ${nick} à tenté un !addpre sur ${chan}, mais le salon n'a pas les *flags* necéssaire."
        return 0;
    }
    # Note de ZarTek :
    # si addpre_(source) est manquant, forcement ce n'ai pas bon, pas besoin de verifier addpre_(section), addpre_(section), addpre_(release)
	# ATTENTION : dans nuke.tcl addpre(source) s'apelle nuke_(net),
	# il est recommander de nommer tous source, ou tous net, mais pas une fois l'un puis l'autre pour respecter une logique
    if { ${addpre_(source)} == "" } {
		set IRC_MSG		[format "\002\0033(\00314ADDPRE\0033)\002\0037 Syntax * !addpre <nom.de.la.release> <section> <source>"]
		putquick "privmsg ${chan} :${IRC_MSG}"
        return 0;
    }

    set SQL_INSERT          "INSERT IGNORE INTO ${::PREEDb0t::mysql_(table)} ( "
    append SQL_INSERT          "`${::PREEDb0t::db_(rlsname)}`, `${::PREEDb0t::db_(grp)}`, `${::PREEDb0t::db_(section)}`, "
    append SQL_INSERT          "`${::PREEDb0t::db_(ctime)}`, `${::PREEDb0t::db_(rls_addpre)}`, `${::PREEDb0t::db_(rls_addpre_nick)}`, "
    append SQL_INSERT          "`${::PREEDb0t::db_(rls_addpre_chan)}`, `${::PREEDb0t::db_(rls_addpre_network)}`, `${::PREEDb0t::db_(rls_addpre_source)}` "
    append SQL_INSERT       ") VALUES ( "
    append SQL_INSERT           "'${addpre_(release)}', '${addpre_(group)}', '${addpre_(section)}', "
    append SQL_INSERT           "'${addpre_(time)}', '1', '${nick}', "
    append SQL_INSERT           "'${chan}', '${::network}', '${addpre_(source)}' "
    append SQL_INSERT       ");"

    set SQL_RESULTAT 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${SQL_INSERT}];
    putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${addpre_(release)}"
    if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } {
        putlog "La release ${addpre_(release)} à été ajouter par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
		set IRC_MSG 	[format "\002\0033(\00314PRE\0033)\002\0037 (%s)\0030 %s" ${addpre_(section)} ${addpre_(release)}]
        putquick "privmsg ${::PREEDb0t::chan_(pred)} :${IRC_MSG}"
    }
    return -1
}
