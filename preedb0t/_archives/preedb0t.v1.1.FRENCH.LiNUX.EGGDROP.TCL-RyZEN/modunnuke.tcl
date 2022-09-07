bind pub -|- !modunnuke ms:modunnuke
proc ms:modunnuke { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314MODUNNUKE\0033)\002\0037 Syntax * !modunnuke <nom.de.la.release> <modunnuke.raison> <modunnuke.net>"
  } else {
   set splitz [split $arg " "]
   set modunnuke_(release) [lrange $splitz 0 0]
   set modunnuke_(release) [string trimleft $modunnuke_(release) "\{"]
   set modunnuke_(release) [string trimright $modunnuke_(release) "\}"]
   set modunnuke_(munraison) [lrange $splitz 1 1]
   set modunnuke_(munraison) [string trimleft $modunnuke_(munraison) "\{"]
   set modunnuke_(munraison) [string trimright $modunnuke_(munraison) "\}"]
   set modunnuke_(munnet) [lrange $splitz 2 2]
   set modunnuke_(munnet) [string trimleft $modunnuke_(munnet) "\{"]
   set modunnuke_(munnet) [string trimright $modunnuke_(munnet) "\}"]
   if { $modunnuke_(release) == "" } { putquick "privmsg $chan \002\0033(\00314MODUNNUKE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }
   if { $modunnuke_(munraison) == "" } { putquick "privmsg $chan \002\0033(\00314MODUNNUKE\0033)\002\0037 Erreur * RAiSON du modunnuke MANQUANT" } else { }
   if { $modunnuke_(munnet) == "" } { putquick "privmsg $chan \002\0033(\00314MODUNNUKE\0033)\002\0037 Erreur * NUKENET du modunnuke MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set modunnuke_(release) [lrange $splitz 0 0]
  set modunnuke_(release) [string trimleft $modunnuke_(release) "\\\{"]
  set modunnuke_(release) [string trimright $modunnuke_(release) "\\\}"]
  set modunnuke_(munraison) [lrange $splitz 1 1]
  set modunnuke_(munraison) [string trimleft $modunnuke_(munraison) "\\\{"]
  set modunnuke_(munraison) [string trimright $modunnuke_(munraison) "\\\}"]
  set modunnuke_(munnet) [lrange $splitz 2 2]
  set modunnuke_(munnet) [string trimleft $modunnuke_(munnet) "\\\{"]
  set modunnuke_(munnet) [string trimright $modunnuke_(munnet) "\\\}"]
  set modunnuke_(munctime) [clock seconds]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$modunnuke_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                      
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(delpre)='0', $db_(moddelpre)='0', $db_(nuke)='0', $db_(modnuke)='0', $db_(unnuke)='0', $db_(undelpre)='0', $db_(modunnuke)='1', $db_(modunnuke_ctime)='$modunnuke_(munctime)', $db_(modunnuke_reason)='$modunnuke_(munraison)', $db_(modunnuke_net)='$modunnuke_(munnet)' WHERE $db_(rlsname)='$modunnuke_(release)'"
   #putquick "privmsg $chan_(nuke) (MODUNNUKE) $modunnuke_(release) - $modunnuke_(munraison) / $modunnuke_(munnet)"
  }
 }
}
