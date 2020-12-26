bind pub -|- !addsfvname ms:addsfvname
proc ms:addsfvname { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan : \002\0033(\00314ADDSFVNAME\0033)\002\0037 Syntax * !addsfvname <nom.de.la.release> <nom_du.sfv>"
  } else {
   set splitz [split $arg " "]
   set addsfvname_(release) [lrange $splitz 0 0]
   set addsfvname_(release) [string trimleft $addsfvname_(release) "\{"]
   set addsfvname_(release) [string trimright $addsfvname_(release) "\}"]
   set addsfvname_(nsfv) [lrange $splitz 1 1]
   set addsfvname_(nsfv) [string trimleft $addsfvname_(nsfv) "\{"]
   set addsfvname_(nsfv) [string trimright $addsfvname_(nsfv) "\}"]
   if { $addsfvname_(release) == "" } { putquick "privmsg $chan : \002\0033(\00314ADDSFVNAME\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }
   if { $addsfvname_(nsfv) == "" } { putquick "privmsg $chan : \002\0033(\00314ADDSFVNAME\0033)\002\0037 Erreur * NOM du SFV MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_
  set splitz [split $arg " "]
  set addsfvname_(release) [lrange $splitz 0 0]
  set addsfvname_(release) [string trimleft $addsfvname_(release) "\\\{"]
  set addsfvname_(release) [string trimright $addsfvname_(release) "\\\}"]
  set addsfvname_(nsfv) [lrange $splitz 1 1]
  set addsfvname_(nsfv) [string trimleft $addsfvname_(nsfv) "\\\{"]
  set addsfvname_(nsfv) [string trimright $addsfvname_(nsfv) "\\\}"]
  set mysql_(select) "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$addsfvname_(release)'"
  set numrel [mysqlsel $mysql_(handle) $mysql_(select)]
  if { $numrel == 0 } { } else {                       
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(sfvname)='$addsfvname_(nsfv)' WHERE $db_(rlsname)='$addsfvname_(release)'"
   #putquick "privmsg $predchan : (ADDSFVNAME) $addsfvname_(release) - $addsfvname_(nsfv)"
  }
 }
}
