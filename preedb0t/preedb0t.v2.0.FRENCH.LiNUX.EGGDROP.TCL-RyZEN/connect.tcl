if { [catch { package require PREEDb0t 2.0 }] } { die "\[preed.tcl - erreur\] le fichier preed.tcl doit être charger en premier dans votre fichier eggdrop.conf" ; return }
bind pub -|- !db_con ::PREEDb0t::dbconnect
proc ::PREEDb0t::dbconnect { nick uhost hand chan arg } {
    set chan        [string tolower ${chan}]
    if { [channel get ${chan} add] } {
        set ::PREEDb0t::mysql_(handle)  [mysqlconnect -host ${::PREEDb0t::mysql_(host)} -user ${::PREEDb0t::mysql_(user)} -password ${::PREEDb0t::mysql_(password)} -db ${::PREEDb0t::mysql_(db)}]
        keepmysqlopen ${::PREEDb0t::mysql_(handle)}
        set IRC_MSG     [format "\002\0033(\00314mySQLd\0033)\002\0037 Connexion au serveur mysqld avec success (ID: %s)et KEEPMYSQLOPEN activer." ${::PREEDb0t::mysql_(handle)}]
        putquick "privmsg ${chan} :${IRC_MSG}"
    }
}

proc ::PREEDb0t::keepmysqlopen {  } {
    mysql::ping ${::PREEDb0t::mysql_(handle)}
    # Note de ZarTeK:
    # Je pense que after est "bloquant" il est preferable d'utiliser timer ou utimer
    after 2000 [list keepmysqlopen ${::PREEDb0t::mysql_(handle)}]
}

proc evnt:init_server { args } {
    set ::PREEDb0t::mysql_(handle) [mysqlconnect -host ${::PREEDb0t::mysql_(host)} -user ${::PREEDb0t::mysql_(user)} -password ${::PREEDb0t::mysql_(password)} -db ${::PREEDb0t::mysql_(db)}]
    ::PREEDb0t::keepmysqlopen ${::PREEDb0t::mysql_(handle)}
    putlog "(mySQLd) Connexion au serveur mysqld avec success et KEEPMYSQLOPEN activer."
}
package provide PREEDb0t-SQL 2.0