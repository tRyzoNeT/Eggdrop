bind pub -|- !addpre ms:addpre
proc ms:addpre { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Syntax * !addpre <nom.de.la.release> <section> <source>"
  } else {
   set splitz [split $arg " "]
   set addpre_(release) [lrange $splitz 0 0]
   set addpre_(release) [string trimleft $addpre_(release) "\{"]
   set addpre_(release) [string trimright $addpre_(release) "\}"]
   set addpre_(section) [lrange $splitz 1 1]
   set addpre_(section) [string trimleft $addpre_(section) "\{"]
   set addpre_(section) [string trimright $addpre_(section) "\}"]
   set addpre_(source) [lrange $splitz 2 2]
   set addpre_(source) [string trimleft $addpre_(source) "\{"]
   set addpre_(source) [string trimright $addpre_(source) "\}"]
   if { $addpre_(release) == "" } { putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANTE" } else { }
   if { $addpre_(section) == "" } { putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * SECTiON MANQUANTE" } else { }
   if { $addpre_(source) == "" } { putquick "privmsg $chan \002\0033(\00314ADDPRE\0033)\002\0037 Erreur * SOURCE MANQUANTE" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global network prefix_ mysql_ db_ chan_
  set splitz [split $arg " "]
  set addpre_(release) [lrange $splitz 0 0]
  set addpre_(release) [string trimleft $addpre_(release) "\\\{"]
  set addpre_(release) [string trimright $addpre_(release) "\\\}"]
  set addpre_(section) [lrange $splitz 1 1]
  set addpre_(section) [string trimleft $addpre_(section) "\\\{"]
  set addpre_(section) [string trimright $addpre_(section) "\\\}"]
  set addpre_(source) [lrange $splitz 2 2]
  set addpre_(source) [string trimleft $addpre_(source) "\\\{"]
  set addpre_(source) [string trimright $addpre_(source) "\\\}"]
  set numrel [mysqlsel $mysql_(handle) "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) = '$addpre_(release)'"]
  if { $numrel != 0 } { } else {
   set addpre_(time) [clock seconds]
   set temp1 [split $addpre_(release) -]
   set group [lindex $temp1 end]
   if { $numrel == 0 } {
    set addpre_(time) [clock seconds]
    set nix [mysqlexec $mysql_(handle) "INSERT INTO $mysql_(table) ($db_(rlsname),$db_(grp),$db_(section),$db_(ctime),$db_(rls_addpre),$db_(rls_addpre_nick),$db_(rls_addpre_chan),$db_(rls_addpre_network),$db_(rls_addpre_source),$db_(rls_addold),$db_(rls_readd),$db_(rls_sitepre)) VALUES ( '$addpre_(release)' , '$group' , '$addpre_(section)' , '$addpre_(time)' , '1' , '$nick' , '$chan' , '$network' , '$addpre_(source)' , '0' , '0' , '0' )"]
    #putquick "privmsg $chan_(pred) (ADDPRE) $addpre_(release) - $addpre_(section)"
   }
  }
 }
}
