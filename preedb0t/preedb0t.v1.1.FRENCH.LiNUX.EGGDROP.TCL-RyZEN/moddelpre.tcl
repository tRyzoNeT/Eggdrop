bind pub -|- !moddelpre ms:moddelpre
proc ms:moddelpre { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan :  \002\0033(\00314MODDELPRE\0033)\002\0037 Syntax * !moddelpre <nom.de.la.release> <moddelpre.raison> <moddelpre.net>"
  } else {
   set splitz [split $arg " "]
   set moddelpre_(release) [lrange $splitz 0 0]
   set moddelpre_(release) [string trimleft $moddelpre_(release) "\{"]
   set moddelpre_(release) [string trimright $moddelpre_(release) "\}"]
   set moddelpre_(mdraison) [lrange $splitz 1 1]
   set moddelpre_(mdraison) [string trimleft $moddelpre_(mdraison) "\{"]
   set moddelpre_(mdraison) [string trimright $moddelpre_(mdraison) "\}"]
   set moddelpre_(mdnet) [lrange $splitz 2 2]
   set moddelpre_(mdnet) [string trimleft $moddelpre_(mdnet) "\{"]
   set moddelpre_(mdnet) [string trimright $moddelpre_(mdnet) "\}"]
   if { $moddelpre_(release) == "" } { putquick "privmsg $chan : \002\0033(\00314MODDELPRE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }    
   if { $moddelpre_(mdraison) == "" } { putquick "privmsg $chan : \002\0033(\00314MODDELPRE\0033)\002\0037 Erreur * RAiSON du moddelpre MANQUANT" } else { }
   if { $moddelpre_(mdnet) == "" } { putquick "privmsg $chan : \002\0033(\00314MODDELPRE\0033)\002\0037 Erreur * NUKENET du moddelpre MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_
  set splitz [split $arg " "]
  set moddelpre_(release) [lrange $splitz 0 0]
  set moddelpre_(release) [string trimleft $moddelpre_(release) "\\\{"]
  set moddelpre_(release) [string trimright $moddelpre_(release) "\\\}"]
  set moddelpre_(mdraison) [lrange $splitz 1 1]
  set moddelpre_(mdraison) [string trimleft $moddelpre_(mdraison) "\\\{"]
  set moddelpre_(mdraison) [string trimright $moddelpre_(mdraison) "\\\}"]
  set moddelpre_(mdnet) [lrange $splitz 2 2]
  set moddelpre_(mdnet) [string trimleft $moddelpre_(mdnet) "\\\{"]
  set moddelpre_(mdnet) [string trimright $moddelpre_(mdnet) "\\\}"]
  set moddelpre_(mdctime) [clock seconds]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$moddelpre_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                       
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(delpre)='0', $db_(modnuke)='0', $db_(nuke)='0', $db_(modunnuke)='0', $db_(unnuke)='0', $db_(undelpre)='0', $db_(moddelpre)='1', $db_(moddelpre_ctime)='$moddelpre_(mdctime)', $db_(moddelpre_reason)='$moddelpre_(mdraison)', $db_(moddelpre_net)='$moddelpre_(mdnet)' WHERE $db_(rlsname)='$moddelpre_(release)'"
   #putquick "privmsg $predchan : (MODDELPRE) $moddelpre_(release) - $moddelpre_(mdraison) / $moddelpre_(mdnet)"
  }
 }
}
