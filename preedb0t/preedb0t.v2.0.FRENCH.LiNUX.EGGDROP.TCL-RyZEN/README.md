** EN TEST, soyez à l'affut ! XD **

# preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN

-------------------------------------------------------------------------------------------------------

# Ce qui est nécessaire au bon fonctionnement :: 
- Les packages debian/ubuntu: ```apt install build-essential libssl-dev```
- [eggdrop](https://www.eggheads.org/) (1.9.3 et plus recommandé) Robot IRC ```git clone https://github.com/eggheads/eggdrop.git```
- [TCL](https://www.tcl.tk/software/tcltk/download.html) (8.6 et plus recommandé) Language TCL ```apt install build-essential tcl tcl-dev  ```
- [MariaDB](https://mariadb.org/download/?t=mariadb&p=mariadb) (10.5.x et plus recommandé) Base de données ```apt install mariadb-server```
- [Tcllib](https://www.tcl.tk/software/tcllib/) (1.20 et plus recommandé) Outils TCL ```apt install tcllib```
- [TclTLS](https://core.tcl-lang.org/tcltls/wiki/Download) (1.7.22 et plus recommandé) Support TLS/SSL pour TCL ```apt install tcl-tls```
- [MySQLTCL](http://www.xdobry.de/mysqltcl/) (3.052 et plus recommandé) Client MySQL/MariaDB pour TCL ```apt install mysqltcl```

# Ce qui est recommandée en plus
- Chaque commande du script à son propre TCL dedié, vous pouvez charger **un tcl par EggDrop**s différents et des serveurs différents.
- **Une connexion gigabit (Gbit) est recommandée.**
- **Disque dur SSD recommander ou NVME pour de meilleures performances.**

  -------------------------------------------------------------------------------------------------------

QUOi DE NOUVEAU?!? DANS LA VERSiON 2.0?!?

- Simplification & Re-Structuration du code, accélère doublement les commandes du eggdrop et éviter des bogues dans l'avenir avec d'autres chargements de TCL.

** Remerciement à ZarTek de https://github.com/ZarTek-Creole pour son temps libre ** :)

Ce TCL garde toujours une connexion 'OUVERTE' au serveur mySQLd (KEEPMYSQLOPEN) ce qui accélère considérablement **toutes** les commandes du eggdrop
et le LAG est beaucoup moins, car il y a toujours une connexion 'OUVERTE' au serveur mySQLd.

  -------------------------------------------------------------------------------------------------------

iNDEX de nos FLAGS :: **p2add - p2db - p2nuker - p2search - p2stats**

- FLAG 'p2add' :: Ajouter à la Database toute information possible
- CMD :: **!addnfoname, !addpre, !addsfvname, !addurl, !genre (!gn), !info !readd**
- CMD :: **!chgsec, !chgurl**
- CMD :: **!delpre, !moddelpre, !modnuke, !modunnuke, !nuke, !undelpre, !unnuke**

  -------------------------------------------------------------------------------------------------------
- FLAG 'p2db' :: Affiche le nombre de releases dans la base de données.
- CMD :: **!db**

  -------------------------------------------------------------------------------------------------------
- FLAG 'p2search' :: Recherche d'informations dans la base de données.
- CMD :: **!dupe !pre**

-------------------------------------------------------------------------------------------------------
- FLAG 'p2stats' :: Affichage des statistiques depuis la dernière heure. (addpre, delpre, nuke, unnuke, etc.)
- CMD :: **!hour**

  -------------------------------------------------------------------------------------------------------

CONFiGURATiON DES FLAGS ::

- Commencez par vous connecter en DCC CHAT avec votre eggdrop
- Ensuite taper la commande **.chanset #votre-channel +FLAG** (exemple : .chanset #addpre +p2add)
- N'oubliez pas de sauvegarder **.save**
- Temps qu'être là pourquoi pas **.rehash** XD

