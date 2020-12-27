bind pub -|- !db ms:mdb
proc ms:mdb {nick uhost hand chan arg} {
 if {[channel get $chan db]} {
  global mysql_ db_
  set handle [mysqlconnect -host $mysql_(host) -user $mysql_(user) -password $mysql_(password) -db $mysql_(db)];
  set row [lindex [mysqlsel $handle "SHOW TABLE STATUS LIKE '$mysql_(table)';" -list] 0]
  set q "SELECT COUNT(id) as nbrls from $mysql_(table)"
  set numrel [mysqlsel $handle $q]
  mysqlmap $handle { nbrls } { 
   putquick "privmsg $chan : \002\0033(\0030DATABASE\0033)\002\003 mysql\0034 $nbrls \003releases dans PreDB \0039-\003 Utilise\0034 [format %.2f [expr [lindex $row 5] / 1024.0]] \003KB"
   mysqlclose $handle
  }
 } else { }
}
