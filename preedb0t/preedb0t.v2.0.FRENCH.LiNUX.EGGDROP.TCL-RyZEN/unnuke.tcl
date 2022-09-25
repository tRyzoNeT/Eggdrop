if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[unnuke.tcl - erreur\] le fichier connect.tcl doit être charger avant nunuke.tcl" ; return }
bind pub -|- !unnuke ::PREEDb0t::unnuke
proc ::PREEDb0t::unnuke { nick uhost hand chan arg } {
 set U_Time   [clock seconds]
 set U_Name  [lindex ${arg} 0]
 set U_Raison   [lindex ${arg} 1]
 set U_Net  [lindex ${arg} 2]
 set U_Grp    [lindex [split ${U_Name} -] end]
 if { ![channel get ${chan} p2nuker] } {
  putlog "L'utilisateur ${nick} à tenté un !unnuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
  return 0;
 }
 if { ${U_Net} == "" } {
  putquick "privmsg ${chan} \002\0033(UNNUKE)\002\0037 Syntax * !unnuke <nom.de.la.release> <unnuke.raison> <nukenet>"
  return 0;
 }
 set U_Sql      "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( `${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, `${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, `${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` ) ";
 append U_Sql   "VALUES ( '${U_Name}', '${U_Grp}', 'unnuke', '${U_Time}', '${U_Raison}', '${U_Net}' );";
 set U_Sqld 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${U_Sql}];
 putlog "L'exécution de la requête a retourné: ${U_Sqld} pour ${U_Name}"
 if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
  putlog "La release \002${U_Name}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
 }
 set U_SqlUP      "UPDATE `${::PREEDb0t::mysql_(table)}` ";
 append U_SqlUP   "SET `${::PREEDb0t::db_(nuke_status)}`='unnuke', `${::PREEDb0t::db_(nuke_ctime)}`='${U_Time}', `${::PREEDb0t::db_(nuke_reason)}`='${U_Raison}', `${::PREEDb0t::db_(nuke_net)}`='${U_Net}' ";
 append U_SqlUP   "WHERE `${::PREEDb0t::db_(rlsname)}`= '${U_Name}';";
 set U_SqldUP     [::mysql::exec ${::PREEDb0t::mysql_(handle)} ${U_SqlUP}];
 set U_Sqldid1    "SELECT `${::PREEDb0t::db_(id)}` FROM `${::PREEDb0t::mysql_(table)}` WHERE `${::PREEDb0t::db_(rlsname)}` LIKE '${U_Name}%'";
 set U_Sqldid2    [::mysql::sel ${::PREEDb0t::mysql_(handle)} ${U_Sqldid1} -flatlist];
 lassign  ${U_Sqldid2} U_Id;
 putlog "L'exécution de la requête a retourné: ${U_SqldUP} pour ${U_Name}";
 if { ${U_SqldUP} != "" } {
  putlog "La release \002${U_Name}\002 à été UNNUKE par ${chan}/${nick} (ID: ${U_Id})";
  set U_IMSG [format "\002\0033(UNNUKE)\002\0037 ${U_Name} \0033-\00315 ${U_Raison} \0033(\00311${U_Net}\0033)"]
  putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${U_IMSG}"
 }
 return -1
}
