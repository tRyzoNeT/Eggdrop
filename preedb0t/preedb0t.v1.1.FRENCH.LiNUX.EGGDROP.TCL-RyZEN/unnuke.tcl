bind pub -|- !unnuke ms:unnuke
proc ms:unnuke { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314UNNUKE\0033)\002\0037 Syntax * !unnuke <nom.de.la.release> <unnuke.raison> <unnuke.net>"
  } else {
   set splitz [split $arg " "]
   set unnuke_(release) [lrange $splitz 0 0]
   set unnuke_(release) [string trimleft $unnuke_(release) "\{"]
   set unnuke_(release) [string trimright $unnuke_(release) "\}"]
   set unnuke_(unraison) [lrange $splitz 1 1]
   set unnuke_(unraison) [string trimleft $unnuke_(unraison) "\{"]
   set unnuke_(unraison) [string trimright $unnuke_(unraison) "\}"]
   set unnuke_(unnet) [lrange $splitz 2 2]
   set unnuke_(unnet) [string trimleft $unnuke_(unnet) "\{"]
   set unnuke_(unnet) [string trimright $unnuke_(unnet) "\}"]
   if { $unnuke_(release) == "" } { putquick "privmsg $chan \002\0033(\00314UNNUKE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }
   if { $unnuke_(unraison) == "" } { putquick "privmsg $chan \002\0033(\00314UNNUKE\0033)\002\0037 Erreur * RAiSON du unnuke MANQUANT" } else { }
   if { $unnuke_(unnet) == "" } { putquick "privmsg $chan \002\0033(\00314UNNUKE\0033)\002\0037 Erreur * NUKENET du unnuke MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set unnuke_(release) [lrange $splitz 0 0]
  set unnuke_(release) [string trimleft $unnuke_(release) "\\\{"]
  set unnuke_(release) [string trimright $unnuke_(release) "\\\}"]
  set unnuke_(unraison) [lrange $splitz 1 1]
  set unnuke_(unraison) [string trimleft $unnuke_(unraison) "\\\{"]
  set unnuke_(unraison) [string trimright $unnuke_(unraison) "\\\}"]
  set unnuke_(unnet) [lrange $splitz 2 2]
  set unnuke_(unnet) [string trimleft $unnuke_(unnet) "\\\{"]
  set unnuke_(unnet) [string trimright $unnuke_(unnet) "\\\}"]
  set unnuke_(unctime) [clock seconds]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$unnuke_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                        
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(delpre)='0', $db_(moddelpre)='0', $db_(modnuke)='0', $db_(modunnuke)='0', $db_(nuke)='0', $db_(undelpre)='0', $db_(unnuke)='1', $db_(unnuke_ctime)='$unnuke_(unctime)', $db_(unnuke_reason)='$unnuke_(unraison)', $db_(unnuke_net)='$unnuke_(unnet)' WHERE $db_(rlsname)='$unnuke_(release)'"
   #putquick "privmsg $chan_(nuke) (UNNUKE) $unnuke_(release) - $unnuke_(unraison) / $unnuke_(unnet)"
  }
 }
}
