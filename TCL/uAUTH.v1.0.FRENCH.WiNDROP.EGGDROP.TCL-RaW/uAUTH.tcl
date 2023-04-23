####################################################################################
#                  uAUTH.v1.0.FRENCH.WiNDROP.EGGDROP.TCL-RaW                       #
#----------------------------------------------------------------------------------#
#                                                                                  #
#               https://github.com/tryzonet   | og@tryzonet.xyz                    #
#                                                                                  #
#----------------------------------------------------------------------------------#
#               UTiLiSATEUR AUTENTiFiCATiON controller vos 'CMD'                   #
#                                                                                  #
# - Supporte WiNDOWS, WiNDROP version 1.8X et plus...                              #
# - Supporte LiNUX, EGGDROP 1.9X et plus...                                        #
#----------------------------------------------------------------------------------#
#       ** LiSTE DES COMMANDES EN 'PRiVÉ' **                                       #
#----------------------------------------------------------------------------------#
# + version 1.0 :: (supporte windrop-windows et eggdrop-linux)                     #
#  - iDENTiFiATiON avec mot-de-pass que vous avez defini (default !login pass)     #
#  - Donne des 'DROiTS' a vos commandes + gestion de membre                        #
#                                                                                  #
#  if { [getuser ${nick} XTRA uauth] != 1 } {                                      #
#   BLABLA VOTRE CODE...                                                           #
#   return false;                                                                  #
#  } else {                                                                        #
#    set umsg	[format "uAUTH * YoOoOooOooo tes pas iDENTiFiER."]                 #
#    putnow "privmsg ${nick} :${umsg}"                                             #
#    return false;                                                                 #
#  }                                                                               #
#                                                                                  #
#  - RESET de tout les users a chaque démarrage & rehash                           #
####################################################################################

if { [info commands ::uAUTH::unload] eq "::uAUTH::unload" } { ::uAUTH::unload }
namespace eval uAUTH {
 # CMD en 'PRiVé' qui éxecute le code du .tcl
 variable CMD "!login";
 variable OUT "!logout";
 # CONFiG 'admin' info du script .tcl
 array set VAR {
  "release" "uAUTH"
  "desc" "*UTiLISATEUR AUTHENTiFiCATiON*"
  "version" "1.0"
  "dev"  "og"
 }
}
bind evnt - userfile-loaded ::uAUTH::userfile-loaded
proc ::uAUTH::userfile-loaded {type} {
 foreach uLUSER [userlist] {
  setuser ${uLUSER} XTRA uauth 0;
 }
 save
}

proc ::uAUTH::unload {args} {
 putlog "-\002${::uAUTH::VAR(release)}\002 dechargement des fichiers *TCL*";
 foreach binding [lsearch -inline -all -regexp [binds *[set ns [string range [namespace current] 2 end]]*] " \{?(::)?${ns}"] {
  unbind [lindex ${binding} 0] [lindex ${binding} 1] [lindex ${binding} 2] [lindex ${binding} 4];
 }
 namespace delete ::uAUTH
}

bind msg - "${::uAUTH::CMD}" ::uAUTH::login
proc ::uAUTH::login { nick uhost hand args } {
 set uid 	${nick};
 set upass 	[lindex ${args} 0];
 # VÉRiFiCATiON si l'utilisateur a 'access'
 if {![validuser [nick2hand ${nick}]]} {
  set umsg	[format "uAUTH ERREUR * Vous n'avez pas access au EGGDROP mybad!!"]
  putnow "privmsg ${nick} :${umsg}"
  return false;
 }
 # VÉRiFiCATiON mot de passe apres la CMD '!login'
 if { ${upass} eq "" } {
  set umsg	[format "uAUTH Syntax * !login <mot-de-pass>"]
  putnow "privmsg ${nick} :${umsg}"
  return false; 
 }
 # VÉRiFiCATiON si l'utilisateur a setter un mot de passe lors de l'ajout du user.
 if { [passwdok ${uid} -] } {
  set umsg	[format "uAUTH ERREUR * Mot de pass NON ENREGiSTRER, (msg <bot> pass <votre-mot-de-pass>)"]
  putnow "privmsg ${nick} :${umsg}"
  return false;
 }
 # VÉRiFiCATiON de l'identification et du mot de pass
 if { ![passwdok ${uid} ${upass}] } {
  set umsg	[format "uAUTH ERREUR * Mot de pass iNVALiDE"]
  putnow "privmsg ${nick} :${umsg}"
  return false;
 }
 if { [getuser ${nick} XTRA uauth] == 1 } {
  set umsg	[format "uAUTH * deja iDENTiFiER"]
  putnow "privmsg ${nick} :${umsg}"
  return false;
 } else {
  setuser ${nick} XTRA uauth 1;
  set umsg	[format "uAUTH * iDENTiFiER avec success"]
  putnow "privmsg ${nick} :${umsg}"
  return false;
 }
}

bind msg - "${::uAUTH::OUT}" ::uAUTH::logout
proc ::uAUTH::logout  { nick uhost hand args } {
    set uid ${nick};
	set uvar  [getuser ${nick} XTRA uauth];
	if {  ${uvar} == 1 } {
        setuser ${uid} XTRA uauth 0
		set umsg 	"uAUTH * [format "Vous êtes bien déconnecter du compte %s." ${uid}]";
		putnow "privmsg ${nick} :${umsg}"
		return false;
	}
	set umsg    "uAUTH * [format "Désolé %s, quelque chose ne fonnctione pas correctement." ${nick}]";
	putnow "privmsg ${nick} :${umsg}"
	return false;
}

package	provide uAUTH ${::uAUTH::VAR(version)};
putlog "-\002${::uAUTH::VAR(release)}\002 ${::uAUTH::VAR(desc)} v${::uAUTH::VAR(version)} par ${::uAUTH::VAR(dev)}... chargement *TCL* avec \002SUCCESS\002.";
