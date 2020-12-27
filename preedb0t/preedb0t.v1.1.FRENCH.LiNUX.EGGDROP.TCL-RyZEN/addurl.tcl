bind pub -|- !addurl ms:addurl
proc ms:addurl { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314ADDURL\0033)\002\0037 Syntax * !addurl <nom.de.la.release> <http://www.lien.url.com>"
  } else {
   set splitz [split $arg " "]
   set addurl_(release) [lrange $splitz 0 0]
   set addurl_(release) [string trimleft $addurl_(release) "\{"]
   set addurl_(release) [string trimright $addurl_(release) "\}"]
   set addurl_(lien) [lrange $splitz 1 1]
   set addurl_(lien) [string trimleft $addurl_(lien) "\{"]
   set addurl_(lien) [string trimright $addurl_(lien) "\}"]
   if { $addurl_(release) == "" } { putquick "privmsg $chan \002\0033(\00314ADDURL\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }
   if { $addurl_(lien) == "" } { putquick "privmsg $chan \002\0033(\00314ADDURL\0033)\002\0037 Erreur * lien URL MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set addurl_(release) [lrange $splitz 0 0]
  set addurl_(release) [string trimleft $addurl_(release) "\\\{"]
  set addurl_(release) [string trimright $addurl_(release) "\\\}"]
  set addurl_(lien) [lrange $splitz 1 1]
  set addurl_(lien) [string trimleft $addurl_(lien) "\\\{"]
  set addurl_(lien) [string trimright $addurl_(lien) "\\\}"]
  set mysql_(select) "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$addurl_(release)'"
  set numrel [mysqlsel $mysql_(handle) $mysql_(select)]
  if { $numrel == 0 } { } else {                       
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(url)='$addurl_(lien)' WHERE $db_(rlsname)='$addurl_(release)'"
   #putquick "privmsg $chan_(pred) (ADDURL) $addurl_(release) - $addurl_(lien)"
  }
 }
}
