### Simple.Auto.Auth.ANOPE.v1.FRENCH.EGGDROP.TCL-RyZEN
### SAA pour ANOPE iRC SERViCES TCL crée par og
### Pour eggdrop version 1.8X et plus...
### LiST CMD EN DCC CHAT :: .saaa_help / .saaa_identify / .saaa_reg
### FLAGS iNDEX ::
### .chanset #chan need-invite saaa_invite #chan (eggdrop s'invite automatique)

### CONFiG iCi
set email "votre@email.ici"
set pass "votre.mot.de.passe"

### CODE
bind dcc o saaa_help n_help
proc n_help {nick host handle} {
 putlog "Simple.Auto.Auth.ANOPE.v1.FRENCH.EGGDROP.TCL-RyZEN ::"
 putlog "- .saaa_identify (s'identifier au nickserv)"
 putlog "- .saaa_reg (s'enregistrer au nickserv)"
 putlog "-"
 putlog "- iNViTATiON AUTO :: .chanset #chan need-invite saaa_invite #chan"
}
### CODE S'iDENTiFiER (iDENTiFY)
bind dcc o saaa_identify n_identify
proc n_identify {nick host handle} {
 global pass
 putquick "PRIVMSG NickServ :identify $pass" 
}
### CODE S'ENREGiSTRER (REGiSTER)
bind dcc o saaa_reg n_register
proc n_register {nick host handle} {
 global pass email
 putquick "PRIVMSG NickServ :register $pass $email"
}
### CODE FLAGS
proc saaa_invite {chan} { putserv "PRIVMSG ChanServ :invite $chan" }
### CODE CONNECT
set init-server {
  putquick "PRIVMSG NickServ :identify $pass"
  putserv "MODE $nick +i"
}
### CODE LOGS
putlog "Simple Auto Auth ANOPE v1 TCL crée par og...ACTiVER (cmd .saaa_help)"

