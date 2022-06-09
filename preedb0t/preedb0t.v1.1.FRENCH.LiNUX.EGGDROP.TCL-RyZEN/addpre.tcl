bind pub -|- !addpre ms:addpre
proc ms:addpre { nick uhost hand chan arg } {
    # Temps actuel
    set addpre_(time) [clock seconds]
    # chan en minuscule
    set chan [string tolower $chan]
    # Verification que le salon a le flag 'add' sinon on arette tout
    if {[channel get $chan add]} { return }
    # si aucun arguments n'ai fournis, on retourne l'aide et on arette tout
    if { $arg == "" } { putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Syntax * !addpre <nom.de.la.release> <section> <source>" }
    # Split sur les espace (je sais pas si utile?)
    set splitz [split $arg " "]
    # lindex au lieu de lrange
    set addpre_(release) [lindex $splitz 0]
   # un trim simple devrais surfir gain dune commande
    set addpre_(release) [string trim $addpre_(release) "\{\}"]
    # et tant que a faire reduison encore:
    set addpre_(section) [string trim [lrange $splitz 1] "\{\}"]
    set addpre_(source)  [string trim [lrange $splitz 2] "\{\}"]
    if { $addpre_(release) == "" } { putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANTE"; return }
    if { $addpre_(section) == "" } { putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * SECTiON MANQUANTE"; return }
    if { $addpre_(source) == "" } { putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * SOURCE MANQUANTE"; return }
    # chargement/importation des variables dans ms:addpre
    global network prefix_ mysql_ db_ chan_
    set group [lindex [split $addpre_(release) -] end]
    # Un index unique sur SQL doit etre present sur la colonne $db_(rlsname) de la table $mysql_(table) pour utuiliser corectement le IGNORE sans ajouter en double
    mysqlexec $mysql_(handle) "INSERT IGNORE INTO $mysql_(table) ($db_(rlsname),$db_(grp),$db_(section),$db_(ctime),$db_(rls_addpre),$db_(rls_addpre_nick),$db_(rls_addpre_chan),$db_(rls_addpre_network),$db_(rls_addpre_source),$db_(rls_addold),$db_(rls_readd),$db_(rls_sitepre)) VALUES ( '$addpre_(release)' , '$group' , '$addpre_(section)' , '$addpre_(time)' , '1' , '$nick' , '$chan' , '$network' , '$addpre_(source)' , '0' , '0' , '0' )"
    # Pour les valeurs: 0 et 1, il doivent etremis comme valeur par defaut dans la structure de la tables et enlever ici pour reduire la longueur de la requette
    #putquick "privmsg $chan_(pred) (ADDPRE) $addpre_(release) - $addpre_(section)"
}
