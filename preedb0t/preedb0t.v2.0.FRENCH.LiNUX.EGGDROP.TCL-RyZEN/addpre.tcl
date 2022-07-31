bind pub -|- !addpre ms:addpre
proc ms:addpre { nick uhost hand chan arg } {
 set addpre_(time)       [clock seconds]
 set chan                [string tolower $chan]
 if { ![channel get ${chan} p2add] } { 
  putlog "L'utilisateur ${nick} à tenté un !addpre sur ${chan}, mais le salon n'a pas les *flags* necéssaire."
  return 0;
 }
 if { ${arg} == "" } { 
  putquick "privmsg ${chan} \002\0033(\00314ADDPRE\0033)\002\0037 Syntax * !addpre <nom.de.la.release>" 
  return 0;
 }
 set addpre_(release)    [lindex ${arg} 0]
 set addpre_(section)    [lindex ${arg} 1]
 set addpre_(source)     [lindex ${arg} 2]
 if { ${addpre_(release)} == "" } { 
  putquick "privmsg ${chan} \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANTE";
  return 0;
 }
 if { ${addpre_(section)} == "" } {
  putquick "privmsg ${chan} \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * SECTiON MANQUANTE";
  return 0;
 }
 if { ${addpre_(source)} == "" } {
  putquick "privmsg ${chan} \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * SOURCE MANQUANTE";
  return 0
 }
 global network prefix_ mysql_ db_ chan_
 set group               [lindex [split ${addpre_(release)} -] end]
 set SQL_INSERT          "INSERT IGNORE INTO $mysql_(table) ( "
 append SQL_INSERT          "`${db_(rlsname)}`, `${db_(grp)}`, `${db_(section)}`, "
 append SQL_INSERT          "`${db_(ctime)}`, `${db_(rls_addpre)}`, `${db_(rls_addpre_nick)}`, "
 append SQL_INSERT          "`${db_(rls_addpre_chan)}`, `${db_(rls_addpre_network)}`, `${db_(rls_addpre_source)}` "
 append SQL_INSERT       ") VALUES ( "
 append SQL_INSERT           "'${addpre_(release)}', '${group}', '${addpre_(section)}', "
 append SQL_INSERT           "'${addpre_(time)}', '1', '${nick}', "
 append SQL_INSERT           "'${chan}', '${network}', '${addpre_(source)}' "
 append SQL_INSERT       ");"

 set SQL_RESULTAT [::mysql::exec ${mysql_(handle)} ${SQL_INSERT}];
 putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${addpre_(release)}"
 if { [::mysql::insertid ${mysql_(handle)}] != "" } {
  putlog "La release ${addpre_(release)} à été ajouter par ${chan}/${nick} (ID: [::mysql::insertid ${mysql_(handle)}])";
  #putquick "privmsg ${chan_(pred)} \002\0033(\00314PRE\0033)\002\0037 (${addpre_(section)})\0030 ${addpre_(release)}"
 }
 return -1
}
