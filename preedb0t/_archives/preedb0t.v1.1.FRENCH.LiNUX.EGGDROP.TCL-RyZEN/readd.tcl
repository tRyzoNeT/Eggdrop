bind pub -|- !readd ms:readd
proc ms:readd { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314READD\0033)\002\0037 Syntax * !readd <nom.de.la.release> <section> <ctime> <readd_network> <readd_source>"
  } else {
   set splitz [split $arg " "]
   set readd_(release) [lrange $splitz 0 0]
   set readd_(release) [string trimleft $readd_(release) "\{"]
   set readd_(release) [string trimright $readd_(release) "\}"]
   set readd_(section) [lrange $splitz 1 1]
   set readd_(section) [string trimleft $readd_(section) "\{"]
   set readd_(section) [string trimright $readd_(section) "\}"]
   set readd_(ctime) [lrange $splitz 2 2]
   set readd_(ctime) [string trimleft $readd_(ctime) "\{"]
   set readd_(ctime) [string trimright $readd_(ctime) "\}"]
   set readd_(network) [lrange $splitz 3 3]
   set readd_(network) [string trimleft $readd_(network) "\{"]
   set readd_(network) [string trimright $readd_(network) "\}"]
   set readd_(source) [lrange $splitz 4 4]
   set readd_(source) [string trimleft $readd_(source) "\{"]
   set readd_(source) [string trimright $readd_(source) "\}"]
   if { $readd_(release) == "" } { putquick "privmsg $chan \002\0033(\00314READD\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANTE" } else { }
   if { $readd_(section) == "" } { putquick "privmsg $chan \002\0033(\00314READD\0033)\002\0037 Erreur * SECTiON MANQUANTE" } else { }
   if { $readd_(ctime) == "" } { putquick "privmsg $chan \002\0033(\00314READD\0033)\002\0037 Erreur * CTiME MANQUANT" } else { }
   if { $readd_(network) == "" } { putquick "privmsg $chan \002\0033(\00314READD\0033)\002\0037 Erreur * NETWORK MANQUANT" } else { }
   if { $readd_(source) == "" } { putquick "privmsg $chan \002\0033(\00314READD\0033)\002\0037 Erreur * SOURCE MANQUANTE" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global prefix_ mysql_ db_ chan_
  set splitz [split $arg " "]
  set readd_(release) [lrange $splitz 0 0]
  set readd_(release) [string trimleft $readd_(release) "\\\{"]
  set readd_(release) [string trimright $readd_(release) "\\\}"]
  set readd_(section) [lrange $splitz 1 1]
  set readd_(section) [string trimleft $readd_(section) "\\\{"]
  set readd_(section) [string trimright $readd_(section) "\\\}"]
  set readd_(ctime) [lrange $splitz 2 2]
  set readd_(ctime) [string trimleft $readd_(ctime) "\\\{"]
  set readd_(ctime) [string trimright $readd_(ctime) "\\\}"]
  set readd_(network) [lrange $splitz 3 3]
  set readd_(network) [string trimleft $readd_(network) "\\\{"]
  set readd_(network) [string trimright $readd_(network) "\\\}"]
  set readd_(source) [lrange $splitz 4 4]
  set readd_(source) [string trimleft $readd_(source) "\\\{"]
  set readd_(source) [string trimright $readd_(source) "\\\}"]
  set numrel [mysqlsel $mysql_(handle) "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) = '$readd_(release)'"]
  if { $numrel != 0 } { } else {
   set readd_(grptmp) [split $readd_(release) -]
   set readd_(group) [lindex $readd_(grptmp) end]
   if { $numrel == 0 } {
    set nix [mysqlexec $mysql_(handle) "INSERT INTO $mysql_(table) ($db_(rlsname),$db_(grp),$db_(section),$db_(ctime),$db_(rls_readd),$db_(rls_readd_nick),$db_(rls_readd_chan),$db_(rls_readd_network),$db_(rls_readd_source),$db_(rls_addold),$db_(rls_addpre),$db_(rls_sitepre)) VALUES ( '$readd_(release)' , '$readd_(group)' , '$readd_(section)' , '$readd_(ctime)' , '1' , '$nick' , '$chan' , '$readd_(network)' , '$readd_(source)' , '0' , '0' , '0' )"]
    #putquick "privmsg $chan_(pred) (READD) $readd_(release) - $readd_(section)"
   }
  }
 }
}
