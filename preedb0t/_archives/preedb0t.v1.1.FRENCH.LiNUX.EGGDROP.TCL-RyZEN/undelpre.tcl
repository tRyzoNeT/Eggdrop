bind pub -|- !undelpre ms:undelpre
proc ms:undelpre { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314UNDELPRE\0033)\002\0037 Syntax * !undelpre <nom.de.la.release> <undelpre.raison> <undelpre.net>"
  } else {
   set splitz [split $arg " "]
   set undelpre_(release) [lrange $splitz 0 0]
   set undelpre_(release) [string trimleft $undelpre_(release) "\{"]
   set undelpre_(release) [string trimright $undelpre_(release) "\}"]
   set undelpre_(udraison) [lrange $splitz 1 1]
   set undelpre_(udraison) [string trimleft $undelpre_(udraison) "\{"]
   set undelpre_(udraison) [string trimright $undelpre_(udraison) "\}"]
   set undelpre_(udnet) [lrange $splitz 2 2]
   set undelpre_(udnet) [string trimleft $undelpre_(udnet) "\{"]
   set undelpre_(udnet) [string trimright $undelpre_(udnet) "\}"]
   if { $undelpre_(release) == "" } { putquick "privmsg $chan \002\0033(\00314UNDELPRE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }
   if { $undelpre_(udraison) == "" } { putquick "privmsg $chan \002\0033(\00314UNDELPRE\0033)\002\0037 Erreur * RAiSON du delpre MANQUANT" } else { }
   if { $undelpre_(udnet) == "" } { putquick "privmsg $chan \002\0033(\00314UNDELPRE\0033)\002\0037 Erreur * NUKENET du delpre MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set undelpre_(release) [lrange $splitz 0 0]
  set undelpre_(release) [string trimleft $undelpre_(release) "\\\{"]
  set undelpre_(release) [string trimright $undelpre_(release) "\\\}"]
  set undelpre_(udraison) [lrange $splitz 1 1]
  set undelpre_(udraison) [string trimleft $undelpre_(udraison) "\\\{"]
  set undelpre_(udraison) [string trimright $undelpre_(udraison) "\\\}"]
  set undelpre_(udnet) [lrange $splitz 2 2]
  set undelpre_(udnet) [string trimleft $undelpre_(udnet) "\\\{"]
  set undelpre_(udnet) [string trimright $undelpre_(udnet) "\\\}"]
  set undelpre_(udctime) [clock seconds]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$undelpre_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                       
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(delpre)='0', $db_(moddelpre)='0', $db_(modnuke)='0', $db_(modunnuke)='0', $db_(nuke)='0', $db_(unnuke)='0', $db_(undelpre)='1', $db_(undelpre_ctime)='$undelpre_(udctime)', $db_(undelpre_reason)='$undelpre_(udraison)', $db_(undelpre_net)='$undelpre_(udnet)' WHERE $db_(rlsname)='$undelpre_(release)'"
   #putquick "privmsg $chan_(nuke) (UNDELPRE) $undelpre_(release) - $undelpre_(udraison) / $undelpre_(udnet)"
  }
 }
}
