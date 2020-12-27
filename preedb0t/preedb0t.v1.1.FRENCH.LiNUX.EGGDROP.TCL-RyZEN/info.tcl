bind pub -|- !info ms:info
proc ms:info { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314iNFO\0033)\002\0037 Syntax * !info <nom.de.la.release> <fichier.rar> <taille.MB>"
  } else {
   set splitz [split $arg " "]
   set info_(release) [lrange $splitz 0 0]
   set info_(release) [string trimleft $info_(release) "\{"]
   set info_(release) [string trimright $info_(release) "\}"]
   set info_(file) [lrange $splitz 1 1]
   set info_(file) [string trimleft $info_(file) "\{"]
   set info_(file) [string trimright $info_(file) "\}"]
   set info_(size) [lrange $splitz 2 2]
   set info_(size) [string trimleft $info_(size) "\{"]
   set info_(size) [string trimright $info_(size) "\}"]
   if { $info_(release) == "" } { putquick "privmsg $chan \002\0033(\00314iNFO\0033)\002\0037 Erreur * nom de la RELEASE MANQUANT" } else { }
   if { $info_(file) == "" } { putquick "privmsg $chan \002\0033(\00314iNFO\0033)\002\0037 Erreur * NOMBRE de fichier MANQUANT" } else { }
   if { $info_(size) == "" } { putquick "privmsg $chan \002\0033(\00314iNFO\0033)\002\0037 Erreur * TAiLLE du fichier MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set info_(release) [lrange $splitz 0 0]
  set info_(release) [string trimleft $info_(release) "\{"]
  set info_(release) [string trimright $info_(release) "\}"]
  set info_(file) [lrange $splitz 1 1]
  set info_(file) [string trimleft $info_(file) "\{"]
  set info_(file) [string trimright $info_(file) "\}"]
  set info_(size) [lrange $splitz 2 2]
  set info_(size) [string trimleft $info_(size) "\{"]
  set info_(size) [string trimright $info_(size) "\}"]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$info_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                        
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(files)='$info_(file)', $db_(size)='$info_(size)' WHERE $db_(rlsname)='$info_(release)'"
   #putquick "privmsg $chan_(pred) (iNFO) $info_(release) - $info_(section)"
  }
 }
}
