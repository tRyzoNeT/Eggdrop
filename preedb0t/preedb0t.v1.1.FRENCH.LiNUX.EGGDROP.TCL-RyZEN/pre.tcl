bind pub -|- !pre ms:pre
proc ms:pre {nick uhost hand chan arg} {
 set chan [string tolower $chan]
 if {[channel get $chan search]} {
  global mysql_ db_
  set ptmp $arg
  set query1 [mysqlsel $mysql_(handle) "SELECT $db_(id),$db_(rlsname),$db_(section),$db_(ctime),$db_(files),$db_(size),$db_(genre),$db_(url),$db_(nfoname),$db_(sfvname),$db_(delpre),$db_(delpre_ctime),$db_(delpre_reason),$db_(delpre_net),$db_(nuke),$db_(nuke_ctime),$db_(nuke_reason),$db_(nuke_net),$db_(moddelpre),$db_(moddelpre_ctime),$db_(moddelpre_reason),$db_(moddelpre_net),$db_(modnuke),$db_(modnuke_ctime),$db_(modnuke_reason),$db_(modnuke_net),$db_(modunnuke),$db_(modunnuke_ctime),$db_(modunnuke_reason),$db_(modunnuke_net),$db_(unnuke),$db_(unnuke_ctime),$db_(unnuke_reason),$db_(unnuke_net),$db_(undelpre),$db_(undelpre_ctime),$db_(undelpre_reason),$db_(undelpre_net) FROM $mysql_(table) WHERE $db_(rlsname) LIKE '%$ptmp%' LIMIT 1" -flatlist];
  if { $query1 == "" } {
   putquick "privmsg $chan \002\0033(\00314PRE\0033)\002\0037 rien trouver pour\00315 $arg"
  } else {
   foreach {id rlsname section ctime files size genre url nfoname sfvname delpre dp_ctime dp_reason dp_net nuke n_ctime n_reason n_net moddelpre md_ctime md_reason md_net modnuke mn_ctime mn_reason mn_net modunnuke mu_ctime mu_reason mu_net unnuke u_ctime u_reason u_net undelpre ud_ctime ud_reason ud_net} $query1 {
    set pctime [unixtime]
    incr pctime -$ctime
    set ago [duration $pctime]
    putquick "privmsg $chan \002\0033(\00314PRE\0033)\002\0037 $rlsname \00311|\00315 $section \0033(\0038 $id \0033)"
    putquick "privmsg $chan \002\0033(\00314cTiME\0033)\002\003 [clock format $ctime -format %d-%m-%Y] [clock format $ctime -format %H:%M:%S] \00311| \0037pred\003 $ago \0037ago"
    if { $files == "" } { } else { putquick "privmsg $chan \002\0033(\00314iNFO\0033)\002\003 $files fichiers \00311|\003 $size mb" }
    if { $genre == "" } { } else { putquick "privmsg $chan \002\0033(\00314GENRE\0033)\002\0030 $genre" }
    if { $url == "" } { } else { putquick "privmsg $chan \002\0033(\00314URL\0033)\002\003 $url" }
    if { $nfoname == "" } { } else { putquick "privmsg $chan \002\0033(\00314NFOname\0033)\002\00370 $nfoname" }
    if { $sfvname == "" } { } else { putquick "privmsg $chan \002\0033(\00314SFVname\0033)\002\00369 $sfvname" }
    if { $delpre == "1" } {
     set dctime [unixtime]
     incr dctime -$dp_ctime
     set dctime_ago [duration $dctime]
     putquick "privmsg $chan \002\0033(\00393DELPRE\0033)\002\0030 $dp_reason \00311|\00315 $dp_net \00311|\003 [clock format $dp_ctime -format %d-%m-%Y] [clock format $dp_ctime -format %H:%M:%S] \00311|\0037 $dp_ctime \00311| \00393delpre\003 $dctime_ago \0037ago"
    } else { }
    if { $nuke == "1" } {
     set nctime [unixtime]
     incr nctime -$n_ctime
     set nctime_ago [duration $nctime]
     putquick "privmsg $chan \002\0033(\0034NUKE\0033)\002\0030 $n_reason \00311|\00315 $n_net \00311|\003 [clock format $n_ctime -format %d-%m-%Y] [clock format $n_ctime -format %H:%M:%S] \00311|\0037 $n_ctime \00311| \0034nuke\003 $nctime_ago \0037ago"
    } else { }
    if { $moddelpre == "1" } {
     set mdctime [unixtime]
     incr mdctime -$md_ctime
     set mdctime_ago [duration $mdctime]
     putquick "privmsg $chan \002\0033(\00394modDELPRE\0033)\002\0030 $md_reason \00311|\00315 $md_net \00311|\003 [clock format $md_ctime -format %d-%m-%Y] [clock format $md_ctime -format %H:%M:%S] \00311|\0037 $md_ctime \00311| \00394moddelpre\003 $mdctime_ago \0037ago"
    } else { }
    if { $modnuke == "1" } {
     set mnctime [unixtime]
     incr mnctime -$mn_ctime
     set mnctime_ago [duration $mnctime]
     putquick "privmsg $chan \002\0033(\00364modNUKE\0033)\002\0030 $mn_reason \00311|\00315 $mn_net \00311|\003 [clock format $mn_ctime -format %d-%m-%Y] [clock format $mn_ctime -format %H:%M:%S] \00311|\0037 $mn_ctime \00311| \00364modnuke\003 $mnctime_ago \0037ago"
    } else { }
    if { $modunnuke == "1" } {
     set muctime [unixtime]
     incr muctime -$mu_ctime
     set muctime_ago [duration $muctime]
     putquick "privmsg $chan \002\0033(\00368modUNNUKE\0033)\002\0030 $mu_reason \00311|\00315 $mu_net \00311|\003 [clock format $mu_ctime -format %d-%m-%Y] [clock format $mu_ctime -format %H:%M:%S] \00311|\0037 $mu_ctime \00311| \00368modunnuke\003 $muctime_ago \0037ago"
    } else { }
    if { $unnuke == "1" } {
     set uctime [unixtime]
     incr uctime -$u_ctime
     set uctime_ago [duration $uctime]
     putquick "privmsg $chan \002\0033(\00356UNNUKE\0033)\002\0030 $u_reason \00311|\00315 $u_net \00311|\003 [clock format $u_ctime -format %d-%m-%Y] [clock format $u_ctime -format %H:%M:%S] \00311|\0037 $u_ctime \00311| \00356unnuke\003 $uctime_ago \0037ago"
    } else { }
    if { $undelpre == "1" } {
     set udctime [unixtime]
     incr udctime -$ud_ctime
     set udctime_ago [duration $udctime]
     putquick "privmsg $chan \002\0033(\00395UNDELPRE\0033)\002\0030 $ud_reason \00311|\00315 $ud_net \00311|\003 [clock format $ud_ctime -format %d-%m-%Y] [clock format $ud_ctime -format %H:%M:%S] \00311|\0037 $ud_ctime \00311| \00395undelpre\003 $udctime_ago \0037ago"
    } else { }
   }
  }
 }
}
