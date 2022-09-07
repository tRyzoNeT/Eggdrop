bind pub -|- !chgsec ms:chgsection
proc ms:chgsection { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314CHGSEC\0033)\002\0037 Syntax * !chgsec <nom.de.la.release> <nouvelle-section>"
  } else {
   set splitz [split $arg " "]
   set chgsec_(release) [lrange $splitz 0 0]
   set chgsec_(release) [string trimleft $chgsec_(release) "\{"]
   set chgsec_(release) [string trimright $chgsec_(release) "\}"]
   set chgsec_(nsection) [lrange $splitz 1 1]
   set chgsec_(nsection) [string trimleft $chgsec_(nsection) "\{"]
   set chgsec_(nsection) [string trimright $chgsec_(nsection) "\}"]
   if { $chgsec_(release) == "" } { putquick "privmsg $chan \002\0033(\00314CHGSEC\0033)\002\0037 Erreur * Nom de la RELEASE MANQUANT" } else { }
   if { $chgsec_(nsection) == "" } { putquick "privmsg $chan \002\0033(\00314CHGSEC\0033)\002\0037 Erreur * NOUVELLE section MANQUANTE" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set chgsec_(release) [lrange $splitz 0 0]
  set chgsec_(release) [string trimleft $chgsec_(release) "\{"]
  set chgsec_(release) [string trimright $chgsec_(release) "\}"]
  set chgsec_(nsection) [lrange $splitz 1 1]
  set chgsec_(nsection) [string trimleft $chgsec_(nsection) "\{"]
  set chgsec_(nsection) [string trimright $chgsec_(nsection) "\}"]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$chgsec_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                       
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(section)='$chgsec_(nsection)' WHERE $db_(rlsname)='$chgsec_(release)'"
   #putquick "privmsg $chan_(pred) (CHGSEC) $chgsec_(release) - $chgsec_(nsection)"
  }
 }
}
