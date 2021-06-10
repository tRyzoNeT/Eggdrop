### Simple.AUTH.Atheme.Anope.v1.FRENCH.EGGDROP.TCL-RyZEN
### ATHEME & ANOPE iRC SERViCES TCL crée par og
### Pour eggdrop version 1.8X et plus...
### LiST CMD EN DCC CHAT :: .ath_help
### FLAGS iNDEX ::
### .chanset #chan need-invite ath_invite #chan (eggdrop s'invite automatique)

### CONFiG iCi
set saaa_(email) "email"
set saaa_(pass) "pass"
set saaa_(nickserv) "NickServ"
set saaa_(chanserv) "ChanServ"
set saaa_(hostserv) "HostServ"

### CODE HELP *CMD*
bind dcc o saaa_help saaa_help
proc saaa_help {nick host handle} {
 putlog "Simple.AUTH.Atheme.Anope.v1.FRENCH.EGGDROP.TCL-RyZEN ::"
 putlog "+ NiCKSERV cmd ::"
 putlog "- .nid (s'identifier au nickserv)"
 putlog "- .nreg (s'enregistrer au nickserv)"
 putlog "+ CHANSERV cmd ::"
 putlog "- .chanset #chan need-invite ath_invite #chan (iNViTATiON AUTO)"
 putlog "+ HOSTSERV cmd ::"
 putlog "- .hreq hostname.demander (requête hostname personnel)"
}

### CODE CHANSERV
proc ath_invite {chan} { 
 global saaa_
 putserv "privmsg $saaa_(chanserv) invite $chan"
}

### CODE HOSTSERV
bind dcc o hreq h_request
proc h_request {arg} {
 global saaa_
 putquick "privmsg $saaa_(hostserv) request $arg"
}

### CODE NiCKSERV
bind dcc o nid n_identify
proc n_identify {nick host handle} {
 global saaa_
 putquick "privmsg $saaa_(nickserv) identify $saaa_(pass)" 
}
bind dcc o nreg n_register
proc n_register {nick host handle} {
 global saaa_
 putquick "privmsg $saaa_(nickserv) register $saaa_(pass) $saaa_(email)"
}

### CODE CONNECT
set init-server {
  putquick "privmsg $saaa_(nickserv) identify $saaa_(pass)"
  putserv "MODE $nick +i"
}
### CODE LOGS
putlog "Simple AUTH Atheme & Anope v1 FRENCH TCL crée par og...ACTiVER (cmd .saaa_help)"
