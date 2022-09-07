bind pub -|- !chgurl ms:chgurl
proc ms:chgurl { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314CHGURL\0033)\002\0037 Syntax * !chgurl <nom.de.la.release> <nouveau-lienURL>"
  } else {
   set splitz [split $arg " "]
   set chgurl_(release) [lrange $splitz 0 0]
   set chgurl_(release) [string trimleft $chgurl_(release) "\{"]
   set chgurl_(release) [string trimright $chgurl_(release) "\}"]
   set chgurl_(nurl) [lrange $splitz 1 1]
   set chgurl_(nurl) [string trimleft $chgurl_(nurl) "\{"]
   set chgurl_(nurl) [string trimright $chgurl_(nurl) "\}"]
   if { $chgurl_(release) == "" } { putquick "privmsg $chan \002\0033(\00314CHGURL\0033)\002\0037 Erreur * Nom de la RELEASE MANQUANT" } else { }
   if { $chgurl_(nurl) == "" } { putquick "privmsg $chan \002\0033(\00314CHGURL\0033)\002\0037 Erreur * NOUVEAU lien URL MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set chgurl_(release) [lrange $splitz 0 0]
  set chgurl_(release) [string trimleft $chgurl_(release) "\{"]
  set chgurl_(release) [string trimright $chgurl_(release) "\}"]
  set chgurl_(nurl) [lrange $splitz 1 1]
  set chgurl_(nurl) [string trimleft $chgurl_(nurl) "\{"]
  set chgurl_(nurl) [string trimright $chgurl_(nurl) "\}"]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$chgurl_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                       
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(url)='$chgurl_(nurl)' WHERE $db_(rlsname)='$chgurl_(release)'"
   #putquick "privmsg $chan_(pred) (CHGURL) $chgurl_(release) - $chgurl_(nurl)"
  }
 }
}
