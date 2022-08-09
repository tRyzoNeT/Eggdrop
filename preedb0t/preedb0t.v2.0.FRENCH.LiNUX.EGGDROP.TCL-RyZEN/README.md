** EN TEST, soyez à l'affut ! XD **

# preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN

-------------------------------------------------------------------------------------------------------

Ce qui est nécessaire au bon fonctionnement :: eggdrop - mysqld - MySQL
Apt install tcl tcl-dev libssl-dev mysqltcl
- Chaque commande à son propre TCL pour éviter le lag.
- Charger vos TCL sur des EggDrops différents et des serveurs différents.
- **Une connexion gigabit (Gbit) est recommandée.**
- Assurez-vous d'avoir une base de données MySQL rapide et performant.
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

