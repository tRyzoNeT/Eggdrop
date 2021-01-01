################################################################################
#  Ce fichier sera mise a jour au fur et a mesure qu'il y a des nouveaux TCL   #
################################################################################
bind pub -|- !cmd ms:cmdlist
proc ms:cmdlist { nick uhost hand chan arg } {
 set chan [string tolower $chan]
 putserv "privmsg $chan + CMD disponible ::"
 if {[channel get $chan add]} {
  putserv "privmsg $chan - ADD :: !db_con (connect manuellement au mySQLd)"
  putserv "privmsg $chan - ADD :: !addpre !addurl !genre & !gn !info !readd"
  putserv "privmsg $chan - ADD :: !chgurl !chgsec"
  putserv "privmsg $chan - ADD :: !delpre !moddelpre !modnuke !modunnuke !nuke !undelpre !unnuke"
 }
 if {[channel get $chan db]} { putserv "privmsg $chan - DB iNFO :: !db" }
 if {[channel get $chan search]} { putserv "privmsg $chan - RECHERCHE :: !dupe !pre" }
 if {[channel get $chan stats]} { putserv "privmsg $chan - STATS iNFO :: !hour" }
}
