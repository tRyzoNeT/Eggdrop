**uAUTH.v1.0.FRENCH.WiNDROP.EGGDROP.TCL-RaW**<br>

Un système d'identification simple, rapide et efficace qui supporte autant windrop (windows) que eggdrop (linux)

**CMD du TCL serais en PV**<br>
S'identifier :: /msg bot !login votre-pass<br>
Déconnexion :: /msg bot !logout

**PS ::** les 'CMD' !login et !logout peuvent etre modifier dans la configuration. 👍

```
if { [getuser ${nick} XTRA uauth] != 1 } {
  #BLABLA VOTRE CODE...
  return false;
} else {
  set umsg	[format "uAUTH * YoOoOooOooo tes pas iDENTiFiER."]
  putnow "privmsg ${nick} :${umsg}"
  return false;
}
```
