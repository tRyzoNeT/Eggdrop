bind pub -|- !addsfvname ms:addsfvname
proc ms:addsfvname { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "PRIVMSG $chan : (addsfvname-syntax) !addsfvname <nom.de.la.release> <nom_du.sfv>"
  } else {
   set splitz [split $arg " "]
   set addsfvname_(release) [lrange $splitz 0 0]
   set addsfvname_(release) [string trimleft $addsfvname_(release) "\{"]
   set addsfvname_(release) [string trimright $addsfvname_(release) "\}"]
   set addsfvname_(nsfv) [lrange $splitz 1 1]
   set addsfvname_(nsfv) [string trimleft $addsfvname_(nsfv) "\{"]
   set addsfvname_(nsfv) [string trimright $addsfvname_(nsfv) "\}"]
   if { $addsfvname_(release) == "" } { putquick "PRIVMSG $chan : (addsfvname-erreur) NOM de la RELEASE MANQUANT" } else { }
   if { $addsfvname_(nsfv) == "" } { putquick "PRIVMSG $chan : (addsfvname-erreur) NOM du SFV MANQUANT" } else { }
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
  set mysql_(handle) [mysqlconnect -host $mysql_(host) -user $mysql_(user) -password $mysql_(password) -db $mysql_(db)]
  set mysql_(select) "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$addsfvname_(release)'"
  set numrel [mysqlsel $mysql_(handle) $mysql_(select)]
  mysqlclose $mysql_(handle)
  if { $numrel == 0 } { } else {
   set mysql_(handle) [mysqlconnect -host $mysql_(host) -user $mysql_(user) -password $mysql_(password) -db $mysql_(db)]                         
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(sfvname)='$addsfvname_(nsfv)' WHERE $db_(rlsname)='$addsfvname_(release)'"
   mysqlclose $mysql_(handle)
   #putquick "PRIVMSG $predchan : (ADDsfvname) $addsfvname_(release) - $addsfvname_(nsfv)"
  }
 }
}
