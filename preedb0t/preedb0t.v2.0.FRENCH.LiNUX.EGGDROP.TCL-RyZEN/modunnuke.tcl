if { [catch { package require PREEDb0t-SQL 2.0 }] } { die "\[modunnuke.tcl - erreur\] le fichier connect.tcl doit être charger avant modunnuke.tcl" ; return }
bind pub -|- !modunnuke ::PREEDb0t::modunnuke
proc ::PREEDb0t::modunnuke { nick uhost hand chan arg } {
 set MU_Time   [clock seconds]
 set MU_Name   [lindex ${arg} 0]
 set MU_Raison [lindex ${arg} 1]
 set MU_Net    [lindex ${arg} 2]
 set MU_Grp    [lindex [split ${MU_Name} -] end]
 if { ![channel get ${chan} p2nuker] } {
  putlog "L'utilisateur ${nick} à tenté un !modunnuke sur ${chan}, mais le salon n'a pas les *flags* nécessaire."
  return 0; 
 }
 if { ${MU_Net} == "" } {
  putquick "privmsg ${chan} \002\0033(\00355MODUNNUKE\0033)\002\0037 Syntax * !modunnuke <nom.de.la.release> <modunnuke.raison> <nukenet>"
  return 0;
 }
 set MU_Sql     "INSERT IGNORE INTO ${::PREEDb0t::mysql_(tablenuke)} ( `${::PREEDb0t::nuke_(rlsname)}`, `${::PREEDb0t::nuke_(grp)}`, `${::PREEDb0t::nuke_(status)}`, `${::PREEDb0t::nuke_(ctime)}`, `${::PREEDb0t::nuke_(reason)}`, `${::PREEDb0t::nuke_(nukenet)}` ) ";
 append MU_Sql  "VALUES ( '${MU_Name}', '${MU_Grp}', 'modunnuke', '${MU_Time}', '${MU_Raison}', '${MU_Net}' );"
 set MU_Sqld 	[::mysql::exec ${::PREEDb0t::mysql_(handle)} ${MU_Sql}];
 putlog "L'exécution de la requête a retourné: ${MU_Sqld} pour ${MU_Name}"
 if { [::mysql::insertid ${::PREEDb0t::mysql_(handle)}] != "" } { 
  putlog "La release \002${MU_Name}\002 à été ajouter a la 'nukedb' par ${chan}/${nick} (ID: [::mysql::insertid ${::PREEDb0t::mysql_(handle)}])";
 }
 set MU_SqlUP      "UPDATE `${::PREEDb0t::mysql_(table)}` ";
 append MU_SqlUP   "SET `${::PREEDb0t::db_(nuke_status)}`='modunnuke', `${::PREEDb0t::db_(nuke_ctime)}`='${MU_Time}', `${::PREEDb0t::db_(nuke_reason)}`='${MU_Raison}', `${::PREEDb0t::db_(nuke_net)}`='${MU_Net}' ";
 append MU_SqlUP   "WHERE `${::PREEDb0t::db_(rlsname)}`='${MU_Name}';";
 set MU_SqldUP     [::mysql::exec ${::PREEDb0t::mysql_(handle)} ${MU_SqlUP}];
 set MU_Sqldid1    "SELECT `${::PREEDb0t::db_(id)}` FROM `${::PREEDb0t::mysql_(table)}` WHERE `${::PREEDb0t::db_(rlsname)}` LIKE '${MU_Name}%'";
 set MU_Sqldid2    [::mysql::sel ${::PREEDb0t::mysql_(handle)} ${MU_Sqldid1} -flatlist];
 lassign  ${MU_Sqldid2} MU_Id;
 putlog "L'exécution de la requête a retourné: ${MU_SqldUP} pour ${MU_Name}"
 if { ${MU_SqldUP} != "" } {
  putlog "La release \002${MU_Name}\002 à été MODUNNUKE par ${chan}/${nick} (ID: ${MU_Id})";
  set MU_IMSG [format "\002\0033(\00355MODUNNUKE\0033)\002\0037 ${MU_Raison} ${MU_Net} ${MU_Name}"]
  putquick "privmsg ${::PREEDb0t::chan_(nuke)} :${MU_IMSG}"
 }
 return -1
}
