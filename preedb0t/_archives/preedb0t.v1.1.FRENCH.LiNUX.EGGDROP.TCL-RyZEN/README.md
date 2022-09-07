# Preedb0t.v1.1.FRENCH.LiNUX.EGGDROP.TCL-RyZEN

**TCL complet a 95%** (il manque **dupe.tcl**)

**Une fois ce TCL complété à 100%, il n'aura plus question de modification sauf s'il a des bugs**

**Je ferais que des ajouts de TCL... soyez à l'affut sur github XD**

-------------------------------------------------------------------------------------------------------

Ce qui est nécessaire au bon fonctionnement :: eggdrop - mysqld - mysqltcl

- Chacune des commandes à son propre TCL pour éviter le lag.
- Charger vos TCL sur des eggdrops différents et des serveurs différent.
- **Une connexion gigabit (gbit) est recommander.**
- Assurez-vous d'avoir une base de données MYSQL rapide et performant.
- **Disque dur SSD recommander ou NVME pour de meilleures performances.**

  -------------------------------------------------------------------------------------------------------

QUOi DE NOUVEAU?!? DANS LA VERSiON 1.1

- Ce TCL garde toujours une connexion 'OUVERTE' au serveur mySQLd (KEEPMYSQLOPEN).
- Sa accélère considérablement TOUTE les commandes du eggdrop.
- Le LAG est beaucoup moin vu qu'il y a toujours une connection 'OUVERTE' au serveur mySQLd.

  -------------------------------------------------------------------------------------------------------
  
iNDEX de nos FLAGS :: **ADD - DB - SEARCH - STATS**

- FLAG 'ADD' :: Ajouter à la database toute information possible
- CMD :: **!addnfoname !addpre !addsfvname !addurl !genre & (!gn) !info !readd**
- CMD :: **!chgsec !chgurl**
- CMD :: **!delpre !moddelpre !modnuke !modunnuke !nuke !undelpre !unnuke**

  -------------------------------------------------------------------------------------------------------
- FLAG 'DB' :: Affiche le nombre de release dans la database.
- CMD :: **!db**

  -------------------------------------------------------------------------------------------------------
- FLAG 'SEARCH' :: Recherche d'informations dans la database.
- CMD :: **!dupe !pre**

-------------------------------------------------------------------------------------------------------
- FLAG 'STATS' :: Affichage des statistiques depuis la dernière heure. (addpre,delpre,nuke,unnuke...etc)
- CMD :: **!hour**

  -------------------------------------------------------------------------------------------------------
  
CONFiGURATiON DES FLAGS ::

- Premièrement connectez-vous en DCC CHAT avec votre eggdrop
- Ensuite tapper la commande **.chanset #votre-channel +FLAG** (exemple: .chanset #addpre +ADD)
- Et n'oubliez pas de sauvegarder **.save**

