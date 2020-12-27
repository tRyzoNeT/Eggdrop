bind pub -|- !modnuke ms:modnuke
proc ms:modnuke { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314MODNUKE\0033)\002\0037 Syntax * !modnuke <nom.de.la.release> <modnuke.raison> <modnuke.net>"
  } else {
   set splitz [split $arg " "]
   set modnuke_(release) [lrange $splitz 0 0]
   set modnuke_(release) [string trimleft $modnuke_(release) "\{"]
   set modnuke_(release) [string trimright $modnuke_(release) "\}"]
   set modnuke_(mnraison) [lrange $splitz 1 1]
   set modnuke_(mnraison) [string trimleft $modnuke_(mnraison) "\{"]
   set modnuke_(mnraison) [string trimright $modnuke_(mnraison) "\}"]
   set modnuke_(mnnet) [lrange $splitz 2 2]
   set modnuke_(mnnet) [string trimleft $modnuke_(mnnet) "\{"]
   set modnuke_(mnnet) [string trimright $modnuke_(mnnet) "\}"]
   if { $modnuke_(release) == "" } { putquick "privmsg $chan \002\0033(\00314MODNUKE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }    
   if { $modnuke_(mnraison) == "" } { putquick "privmsg $chan \002\0033(\00314MODNUKE\0033)\002\0037 Erreur * RAiSON du modnuke MANQUANT" } else { }
   if { $modnuke_(mnnet) == "" } { putquick "privmsg $chan \002\0033(\00314MODNUKE\0033)\002\0037 Erreur * NUKENET du modnuke MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set modnuke_(release) [lrange $splitz 0 0]
  set modnuke_(release) [string trimleft $modnuke_(release) "\\\{"]
  set modnuke_(release) [string trimright $modnuke_(release) "\\\}"]
  set modnuke_(mnraison) [lrange $splitz 1 1]
  set modnuke_(mnraison) [string trimleft $modnuke_(mnraison) "\\\{"]
  set modnuke_(mnraison) [string trimright $modnuke_(mnraison) "\\\}"]
  set modnuke_(mnnet) [lrange $splitz 2 2]
  set modnuke_(mnnet) [string trimleft $modnuke_(mnnet) "\\\{"]
  set modnuke_(mnnet) [string trimright $modnuke_(mnnet) "\\\}"]
  set modnuke_(mnctime) [clock seconds]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$modnuke_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                        
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(delpre)='0', $db_(moddelpre)='0', $db_(nuke)='0', $db_(modunnuke)='0', $db_(unnuke)='0', $db_(undelpre)='0', $db_(modnuke)='1', $db_(modnuke_ctime)='$modnuke_(mnctime)', $db_(modnuke_reason)='$modnuke_(mnraison)', $db_(modnuke_net)='$modnuke_(mnnet)' WHERE $db_(rlsname)='$modnuke_(release)'"
   #putquick "privmsg $chan_(pred) (MODNUKE) $modnuke_(release) - $modnuke_(mnraison) / $modnuke_(mnnet)"
  }
 }
}
