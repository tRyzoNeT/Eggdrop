bind pub -|- !nuke ms:nuke
proc ms:nuke { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan : \002\0033(\00314NUKE\0033)\002\0037 Syntax * !nuke <nom.de.la.release> <nuke.raison> <nukenet>"
  } else {
   set splitz [split $arg " "]
   set nuke_(release) [lrange $splitz 0 0]
   set nuke_(release) [string trimleft $nuke_(release) "\{"]
   set nuke_(release) [string trimright $nuke_(release) "\}"]
   set nuke_(nraison) [lrange $splitz 1 1]
   set nuke_(nraison) [string trimleft $nuke_(nraison) "\{"]
   set nuke_(nraison) [string trimright $nuke_(nraison) "\}"]
   set nuke_(nnet) [lrange $splitz 2 2]
   set nuke_(nnet) [string trimleft $nuke_(nnet) "\{"]
   set nuke_(nnet) [string trimright $nuke_(nnet) "\}"]
   if { $nuke_(release) == "" } { putquick "privmsg $chan : \002\0033(\00314NUKE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }
   if { $nuke_(nraison) == "" } { putquick "privmsg $chan : \002\0033(\00314NUKE\0033)\002\0037 Erreur * RAiSON du nuke MANQUANT" } else { }
   if { $nuke_(nnet) == "" } { putquick "privmsg $chan : \002\0033(\00314NUKE\0033)\002\0037 Erreur * NUKENET du nuke MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_
  set splitz [split $arg " "]
  set nuke_(release) [lrange $splitz 0 0]
  set nuke_(release) [string trimleft $nuke_(release) "\\\{"]
  set nuke_(release) [string trimright $nuke_(release) "\\\}"]
  set nuke_(nraison) [lrange $splitz 1 1]
  set nuke_(nraison) [string trimleft $nuke_(nraison) "\\\{"]
  set nuke_(nraison) [string trimright $nuke_(nraison) "\\\}"]
  set nuke_(nnet) [lrange $splitz 2 2]
  set nuke_(nnet) [string trimleft $nuke_(nnet) "\\\{"]
  set nuke_(nnet) [string trimright $nuke_(nnet) "\\\}"]
  set nuke_(nctime) [clock seconds]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$nuke_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                        
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(delpre)='0', $db_(moddelpre)='0', $db_(modnuke)='0', $db_(modunnuke)='0', $db_(unnuke)='0', $db_(undelpre)='0', $db_(nuke)='1', $db_(nuke_ctime)='$nuke_(nctime)', $db_(nuke_reason)='$nuke_(nraison)', $db_(nuke_net)='$nuke_(nnet)' WHERE $db_(rlsname)='$nuke_(release)'"
   #putquick "privmsg $predchan : (NUKE) $nuke_(release) - $nuke_(nraison) / $nuke_(nnet)"
  }
 }
}
