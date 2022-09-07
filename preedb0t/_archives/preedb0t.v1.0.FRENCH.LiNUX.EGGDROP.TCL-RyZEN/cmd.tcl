bind pub -|- !cmd ms:cmdlist
proc ms:cmdlist { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 putserv "PRIVMSG $chan : + CMD disponible ::"
 if {[channel get $chan add]} { 
  putserv "PRIVMSG $chan : - ADD :: !addpre !addurl !info !readd"
  putserv "PRIVMSG $chan : - ADD NUD :: !delpre !moddelpre !modnuke !modunnuke !nuke !undelpre !unnuke"
 }
 if {[channel get $chan db]} { putserv "PRIVMSG $chan : - DB iNFO :: !db" }
 if {[channel get $chan search]} { putserv "PRIVMSG $chan : - SEARCH :: !dupe !pre" }
 if {[channel get $chan stats]} { putserv "PRIVMSG $chan : - STATS iNFO :: !hour" }
}
