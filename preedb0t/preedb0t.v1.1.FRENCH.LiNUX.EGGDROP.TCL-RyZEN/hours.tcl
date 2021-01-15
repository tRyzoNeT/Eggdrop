bind pub -|- !hour ms:hour_public
proc ms:hour_public { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan stats]} {
  global mysql_ db_ chan_
  set now [clock seconds]
  set dur [expr $now - 3600]
  set addpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(ctime) > $dur"
  set addpre_tmp [mysqlsel $mysql_(handle) $addpre]
  set delpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(delpre)=1 AND $db_(ctime) > $dur"
  set delpre_tmp [mysqlsel $mysql_(handle) $delpre]
  set nuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(nuke)=1 AND $db_(ctime) > $dur"
  set nuke_tmp [mysqlsel $mysql_(handle) $nuke]
  set moddelpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(moddelpre)=1 AND $db_(ctime) > $dur"
  set moddelpre_tmp [mysqlsel $mysql_(handle) $moddelpre]
  set modnuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(modnuke)=1 AND $db_(ctime) > $dur"
  set modnuke_tmp [mysqlsel $mysql_(handle) $modnuke]
  set modunnuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(modunnuke)=1 AND $db_(ctime) > $dur"
  set modunnuke_tmp [mysqlsel $mysql_(handle) $modunnuke]
  set undelpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(undelpre)=1 AND $db_(ctime) > $dur"
  set undelpre_tmp [mysqlsel $mysql_(handle) $undelpre]
  set unnuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(unnuke)=1 AND $db_(ctime) > $dur"
  set unnuke_tmp [mysqlsel $mysql_(handle) $unnuke]
  putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\003 depuis la dernière heure \0039::"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $addpre_tmp \003release on été \002\00310ADDPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $delpre_tmp \003release on été \002\00314DELPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $nuke_tmp \003release on été \002\0034NUKE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $moddelpre_tmp \003release on été \002\00314modDELPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $modnuke_tmp \003release on été \002\0034modNUKE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $modunnuke_tmp \003release on été \002\0033modUNNUKE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $undelpre_tmp \003release on été \002\00314unDELPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $unnuke_tmp \003release on été \002\0033unNUKE\002"
 }
}

bind time -|- "00 * * * *" ms:hour
proc ms:hour { min hour day month year } {
 global mysql_ db_ chan_
 set now [clock seconds]
 set dur [expr $now - 3600]
 set addpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(ctime) > $dur"
 set addpre_tmp [mysqlsel $mysql_(handle) $addpre]
 set delpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(delpre)=1 AND $db_(ctime) > $dur"
 set delpre_tmp [mysqlsel $mysql_(handle) $delpre]
 set nuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(nuke)=1 AND $db_(ctime) > $dur"
 set nuke_tmp [mysqlsel $mysql_(handle) $nuke]
 set moddelpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(moddelpre)=1 AND $db_(ctime) > $dur"
 set moddelpre_tmp [mysqlsel $mysql_(handle) $moddelpre]
 set modnuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(modnuke)=1 AND $db_(ctime) > $dur"
 set modnuke_tmp [mysqlsel $mysql_(handle) $modnuke]
 set modunnuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(modunnuke)=1 AND $db_(ctime) > $dur"
 set modunnuke_tmp [mysqlsel $mysql_(handle) $modunnuke]
 set undelpre "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(undelpre)=1 AND $db_(ctime) > $dur"
 set undelpre_tmp [mysqlsel $mysql_(handle) $undelpre]
 set unnuke "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%' AND $db_(unnuke)=1 AND $db_(ctime) > $dur"
 set unnuke_tmp [mysqlsel $mysql_(handle) $unnuke]
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\003 depuis la dernière heure \0039::"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $addpre_tmp \003release on été \002\00310ADDPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $delpre_tmp \003release on été \002\00314DELPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $nuke_tmp \003release on été \002\0034NUKE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $moddelpre_tmp \003release on été \002\00314modDELPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $modnuke_tmp \003release on été \002\0034modNUKE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $modunnuke_tmp \003release on été \002\0033modUNNUKE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $undelpre_tmp \003release on été \002\00314unDELPRE\002"
 putquick "privmsg $chan_(stats) \002\0033(\0030ST\0039A\0030TS\0033)\002\0038 $unnuke_tmp \003release on été \002\0033unNUKE\002"
}
