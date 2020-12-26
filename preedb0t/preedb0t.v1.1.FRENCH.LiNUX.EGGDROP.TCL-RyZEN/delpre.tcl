bind pub -|- !delpre ms:delpre
proc ms:delpre { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan :  \002\0033(\00314DELPRE\0033)\002\0037 Syntax * !delpre <nom.de.la.release> <delpre.raison> <delpre.nukenet>"
  } else {
   set splitz [split $arg " "]
   set delpre_(release) [lrange $splitz 0 0]
   set delpre_(release) [string trimleft $delpre_(release) "\{"]
   set delpre_(release) [string trimright $delpre_(release) "\}"]
   set delpre_(draison) [lrange $splitz 1 1]
   set delpre_(draison) [string trimleft $delpre_(draison) "\{"]
   set delpre_(draison) [string trimright $delpre_(draison) "\}"]
   set delpre_(dnnet) [lrange $splitz 2 2]
   set delpre_(dnnet) [string trimleft $delpre_(dnnet) "\{"]
   set delpre_(dnnet) [string trimright $delpre_(dnnet) "\}"]
   if { $delpre_(release) == "" } { putquick "privmsg $chan : \002\0033(\00314DELPRE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }
   if { $delpre_(draison) == "" } { putquick "privmsg $chan : \002\0033(\00314DELPRE\0033)\002\0037 Erreur * RAiSON du delpre MANQUANT" } else { }
   if { $delpre_(dnnet) == "" } { putquick "privmsg $chan : \002\0033(\00314DELPRE\0033)\002\0037 Erreur * NUKENET du delpre MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_
  set splitz [split $arg " "]
  set delpre_(release) [lrange $splitz 0 0]
  set delpre_(release) [string trimleft $delpre_(release) "\\\{"]
  set delpre_(release) [string trimright $delpre_(release) "\\\}"]
  set delpre_(draison) [lrange $splitz 1 1]
  set delpre_(draison) [string trimleft $delpre_(draison) "\\\{"]
  set delpre_(draison) [string trimright $delpre_(draison) "\\\}"]
  set delpre_(dnnet) [lrange $splitz 2 2]
  set delpre_(dnnet) [string trimleft $delpre_(dnnet) "\\\{"]
  set delpre_(dnnet) [string trimright $delpre_(dnnet) "\\\}"]
  set delpre_(dctime) [clock seconds]
  set mysql_(select) "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$delpre_(release)'"
  set numrel [mysqlsel $mysql_(handle) $mysql_(select)]
  if { $numrel == 0 } { } else {                        
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(nuke)='0', $db_(moddelpre)='0', $db_(modnuke)='0', $db_(modunnuke)='0', $db_(unnuke)='0', $db_(undelpre)='0', $db_(delpre)='1', $db_(delpre_ctime)='$delpre_(dctime)', $db_(delpre_reason)='$delpre_(draison)', $db_(delpre_net)='$delpre_(dnnet)' WHERE $db_(rlsname)='$delpre_(release)'"
   #putquick "privmsg $predchan : (DELPRE) $delpre_(release) - $delpre_(draison) / $delpre_(dnet)"
  }
 }
}
