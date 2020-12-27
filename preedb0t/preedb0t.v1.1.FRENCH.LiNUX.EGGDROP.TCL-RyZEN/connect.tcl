bind pub -|- !db_con ms:dbconnect
proc ms:dbconnect { nick uhost hand chan arg } {
 set chan [string tolower $chan]                                       
 if {[channel get $chan add]} {
  global mysql_
  set mysql_(handle) [mysqlconnect -host $mysql_(host) -user $mysql_(user) -password $mysql_(password) -db $mysql_(db)]
  keepmysqlopen $mysql_(handle)
  putquick "privmsg $chan : \002\0033(\00314mySQLd\0033)\002\0037 Connexion au serveur mysqld avec success et KEEPMYSQLOPEN activer."
 }
}

proc keepmysqlopen {db_idle} {
 mysql::ping $db_idle
 after 2000 [list keepmysqlopen $db_idle]
}

proc evnt:init_server {type} {
 global mysql_
 set mysql_(handle) [mysqlconnect -host $mysql_(host) -user $mysql_(user) -password $mysql_(password) -db $mysql_(db)]
 keepmysqlopen $mysql_(handle)
 putlog "(mySQLd) Connexion au serveur mysqld avec success et KEEPMYSQLOPEN activer."
}
