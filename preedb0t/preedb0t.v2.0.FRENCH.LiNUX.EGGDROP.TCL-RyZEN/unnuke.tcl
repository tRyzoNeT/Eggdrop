bind pub -|- !unnuke ms:unnuke
proc ms:unnuke { nick uhost hand chan arg } {
 set unnuke_(time) [clock seconds]
 set chan [string tolower ${chan}]
 if { ![channel get ${chan} p2nuker] } {
  putlog "L'utilisateur ${nick} à tenté un !unnuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
  return 0;
 }
 if { ${arg} == "" } {
  putquick "privmsg ${chan} \002\0033(UNNUKE)\002\0037 Syntax * !unnuke <nom.de.la.release> <unnuke.raison> <unnukenet>"
  return 0;
 }
 set unnuke_(release) [lindex ${arg} 0]
 set unnuke_(raison) [lindex ${arg} 1]
 set unnuke_(net) [lindex ${arg} 2]
 if { ${unnuke_(release)} == "" } { 
  putquick "privmsg ${chan} \002\0033(UNNUKE)\002\0037 Erreur * NOM de la RELEASE MANQUANTE";
  return 0;
 }
 if { ${unnuke_(raison)} == "" } {
  putquick "privmsg ${chan} \002\0033(UNNUKE)\002\0037 Erreur * RAiSON du unnuke MANQUANT";
  return 0;
 }
 if { ${unnuke_(net)} == "" } {
  putquick "privmsg ${chan} \002\0033(UNNUKE)\002\0037 Erreur * NUKENET du unnuke MANQUANT";
  return 0
 }
 global network prefix_ mysql_ db_ chan_
 set group [lindex [split ${unnuke_(release)} -] end]
 set SQL_INSERT "UPDATE IGNORE $mysql_(table) SET "
 append SQL_INSERT          "$db_(delpre)='0', $db_(moddelpre)='0', $db_(modnuke)='0', $db_(modunnuke)='0', $db_(nuke)='0', $db_(undelpre)='0', "
 append SQL_INSERT          "$db_(unnuke)='1', $db_(unnuke_ctime)='$unnuke_(time)', $db_(unnuke_reason)='$unnuke_(raison)', $db_(unnuke_net)='$unnuke_(net)' "
 append SQL_INSERT       "WHERE $db_(rlsname)='$unnuke_(release)'"
 set SQL_RESULTAT [::mysql::exec ${mysql_(handle)} ${SQL_INSERT}];
 putlog "L'exécution de la requête a retourné: ${SQL_RESULTAT} pour ${unnuke_(release)}"
 if { [::mysql::insertid ${mysql_(handle)}] != "" } {
  putlog "La release \002${unnuke_(release)}\002 à été UNNUKE par ${chan}/${nick} (ID: [::mysql::insertid ${mysql_(handle)}])";
  putquick "privmsg ${chan_(nuke)} \002\0033(UNNUKE)\002\0037 (${unnuke_(raison)} - ${unnuke_(net)})\0030 ${unnuke_(release)}"
 }
 return -1
}
