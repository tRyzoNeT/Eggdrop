bind pub -|- !addnfoname ms:addnfoname
proc ms:addnfoname { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "PRIVMSG $chan : (addnfoname-syntax) !addnfoname <nom.de.la.release> <nom_du.nfo>"
  } else {
   set splitz [split $arg " "]
   set addnfoname_(release) [lrange $splitz 0 0]
   set addnfoname_(release) [string trimleft $addnfoname_(release) "\{"]
   set addnfoname_(release) [string trimright $addnfoname_(release) "\}"]
   set addnfoname_(nnfo) [lrange $splitz 1 1]
   set addnfoname_(nnfo) [string trimleft $addnfoname_(nnfo) "\{"]
   set addnfoname_(nnfo) [string trimright $addnfoname_(nnfo) "\}"]
   if { $addnfoname_(release) == "" } { putquick "PRIVMSG $chan : (addnfoname-erreur) NOM de la RELEASE MANQUANT" } else { }
   if { $addnfoname_(nnfo) == "" } { putquick "PRIVMSG $chan : (addnfoname-erreur) NOM du NFO MANQUANT" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_
  set splitz [split $arg " "]
  set addnfoname_(release) [lrange $splitz 0 0]
  set addnfoname_(release) [string trimleft $addnfoname_(release) "\\\{"]
  set addnfoname_(release) [string trimright $addnfoname_(release) "\\\}"]
  set addnfoname_(nnfo) [lrange $splitz 1 1]
  set addnfoname_(nnfo) [string trimleft $addnfoname_(nnfo) "\\\{"]
  set addnfoname_(nnfo) [string trimright $addnfoname_(nnfo) "\\\}"]
  set mysql_(handle) [mysqlconnect -host $mysql_(host) -user $mysql_(user) -password $mysql_(password) -db $mysql_(db)]
  set mysql_(select) "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$addnfoname_(release)'"
  set numrel [mysqlsel $mysql_(handle) $mysql_(select)]
  mysqlclose $mysql_(handle)
  if { $numrel == 0 } { } else {
   set mysql_(handle) [mysqlconnect -host $mysql_(host) -user $mysql_(user) -password $mysql_(password) -db $mysql_(db)]                         
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(nfoname)='$addnfoname_(nnfo)' WHERE $db_(rlsname)='$addnfoname_(release)'"
   mysqlclose $mysql_(handle)
   #putquick "PRIVMSG $predchan : (ADDnfoname) $addnfoname_(release) - $addnfoname_(lien)"
  }
 }
}
