###
### UUP.v0.1.FRENCH.EGGDROP.LiNUX.TCL-RyZEN TCL crée par og
###
### TCL SiMPLE, info Uptime de votre systeme
### .chanset #chan +uup
###
### - NE Supporte PAS WiNDOWS, WiNDROP...
### - Supporte LiNUX, EGGDROP 1.9X et plus...
###
### ** Prenez note, ce .tcl ne fonctionne pas sous WiNDOWS(windrop)
###

### CONFiGURATiON iCi SEULEMENT
setudef flag uup
namespace eval UUP {
 array set VAR {
    "cmd" "!uptime"
    "release" "UUP"
    "desc" "*Uptime & Systeme info*"
    "version" "v0.1"
    "dev" "og"
 }
}

bind pub -|- ${::UUP::VAR(cmd)} UUP_Exec

### CODiNG
proc UUP_Exec { nick uhost hand chan arg } {
    if { ![channel get ${chan} uup] } {
        set UUP_LOGERR	[format "L'utilisateur %s à tenté la cmd !uptime sur %s, mais le salon n'a pas les *flags* necéssaire." ${nick} ${chan}]
        return -code error ${UUP_LOGERR};
    }
    putquick "PRIVMSG ${chan} :[UUP_Echo]"
    return 1
}
proc UUP_Echo { } {
 if {[catch {exec uptime} UUP_Time]} { set UUP_Time "UPTiME NON DiSPONiBLE." }
 if {[catch {exec uname -sr} UUP_Pc]} { set UUP_Pc [unames] }
 if {[catch {exec hostname} UUP_Host]} { set UUP_Host [info hostname] }
 return "(UPTiME) pour ${UUP_Host} ($UUP_Pc) ${UUP_Time}"
}
package provide Uptime 0.1

### LOGS
putlog "-\002${::UUP::VAR(release)}\002 ${::UUP::VAR(desc)} ${::UUP::VAR(version)} par ${::UUP::VAR(dev)}";
