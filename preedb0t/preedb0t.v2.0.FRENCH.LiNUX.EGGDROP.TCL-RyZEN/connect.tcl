if { [catch { package require PREEDb0t 2.0 }] } { die "\[preed.tcl - erreur\] le fichier preed.tcl doit être charger en premier dans votre fichier eggdrop.conf" ; return }

proc ::PREEDb0t::MySQL:KeepAlive {} {
	if { ![info exists ::PREEDb0t::mysql_(handle)] || [mysql::state ${::PREEDb0t::mysql_(handle)} -numeric] == 0 || ![mysql::ping ${::PREEDb0t::mysql_(handle)}] } {
		if { [catch { set ::PREEDb0t::mysql_(handle) [::mysql::connect -host ${::PREEDb0t::mysql_(host)} -user ${::PREEDb0t::mysql_(user)} -password ${::PREEDb0t::mysql_(password)} -db ${::PREEDb0t::mysql_(db)}] } MYSQL_ERR] } {
			if { [string match "*Access*denied*" ${MYSQL_ERR}] } {
				die "PREEDb0t: Verifier les informations MySQ"
			}
			die "SQL FATAL ERROR (::mysql::connect): ${MYSQL_ERR}"
		}
	}
    putlog "PREEDb0t: (mySQLd) (Re)Connexion au serveur mysqld avec success: ${::PREEDb0t::mysql_(handle)}"
	utimer 120 [list ::PREEDb0t::MySQL:KeepAlive]
	return 0
}
::PREEDb0t::MySQL:KeepAlive 
package provide PREEDb0t-SQL 2.0