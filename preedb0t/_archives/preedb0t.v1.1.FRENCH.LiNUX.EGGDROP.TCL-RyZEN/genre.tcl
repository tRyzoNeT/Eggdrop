bind pub -|- !genre ms:genre
bind pub -|- !gn ms:genre
proc ms:genre { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 if {[channel get $chan add]} {
  if { $arg == "" } {
   putquick "privmsg $chan \002\0033(\00314GENRE\0033)\002\0037 Syntax * !genre <nom.de.la.release> <genre_exemple_Action.Thriller"
  } else {
   set splitz [split $arg " "]
   set genre_(release) [lrange $splitz 0 0]
   set genre_(release) [string trimleft $genre_(release) "\{"]
   set genre_(release) [string trimright $genre_(release) "\}"]
   set genre_(genre) [lrange $splitz 1 1]
   set genre_(genre) [string trimleft $genre_(genre) "\{"]
   set genre_(genre) [string trimright $genre_(genre) "\}"]
   if { $genre_(release) == "" } { putquick "privmsg $chan \002\0033(\00314GENRE\0033)\002\0037 Erreur * NOM de la RELEASE MANQUANT" } else { }   
   if { $genre_(genre) == "" } { putquick "privmsg $chan \002\0033(\00314GENRE\0033)\002\0037 Erreur * genre MANQUANT ou il y a une ESPACE" } else { }
  }
 }
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_ db_ chan_
  set splitz [split $arg " "]
  set genre_(release) [lrange $splitz 0 0]
  set genre_(release) [string trimleft $genre_(release) "\\\{"]
  set genre_(release) [string trimright $genre_(release) "\\\}"]
  set genre_(genre) [lrange $splitz 1 1]
  set genre_(genre) [string trimleft $genre_(genre) "\\\{"]
  set genre_(genre) [string trimright $genre_(genre) "\\\}"]
  set q "SELECT $db_(id) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '$genre_(release)'"
  set numrel [mysqlsel $mysql_(handle) $q]
  if { $numrel == 0 } { } else {                       
   mysqlexec $mysql_(handle) "UPDATE $mysql_(table) SET $db_(genre)='$genre_(genre)' WHERE $db_(rlsname)='$genre_(release)'"
   #putquick "privmsg $chan_(pred) (GENRE) $genre_(release) - $genre_(genre)"
  }
 }
}
