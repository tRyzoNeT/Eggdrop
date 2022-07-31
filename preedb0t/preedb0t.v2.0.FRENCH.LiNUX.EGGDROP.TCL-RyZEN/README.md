** EN TEST soyez à l'affut XD**

# preedb0t.v2.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN

-------------------------------------------------------------------------------------------------------

Ce qui est nécessaire au bon fonctionnement :: eggdrop - mysqld - mysqltcl

- Chacune des commandes à son propre TCL pour éviter le lag.
- Charger vos TCL sur des eggdrops différents et des serveurs différent.
- **Une connexion gigabit (gbit) est recommander.**
- Assurez-vous d'avoir une base de données MYSQL rapide et performant.
- **Disque dur SSD recommander ou NVME pour de meilleures performances.**

  -------------------------------------------------------------------------------------------------------

QUOi DE NOUVEAU?!? DANS LA VERSiON 2.0?!?

- Simplification & Re-Structuration du code, accélère doublement les commandes du eggdrop et éviter des bugs dans le futur avec d'autre chargement de TCL.

**Remerciement a ZarTek Creole github pour sont temps libres** :)

Ce TCL garde toujours une connexion 'OUVERTE' au serveur mySQLd (KEEPMYSQLOPEN) ce qui accélère considérablement TOUTE les commandes du eggdrop
et le LAG est beaucoup moin vu qu'il y a toujours une connection 'OUVERTE' au serveur mySQLd.

  -------------------------------------------------------------------------------------------------------
  
iNDEX de nos FLAGS :: **p2add - p2db - p2nuker - p2search - p2stats**

- FLAG 'p2add' :: Ajouter à la database toute information possible
- CMD :: **!addnfoname !addpre !addsfvname !addurl !genre & (!gn) !info !readd**
- CMD :: **!chgsec !chgurl**
- CMD :: **!delpre !moddelpre !modnuke !modunnuke !nuke !undelpre !unnuke**

  -------------------------------------------------------------------------------------------------------
- FLAG 'p2db' :: Affiche le nombre de release dans la database.
- CMD :: **!db**

  -------------------------------------------------------------------------------------------------------
- FLAG 'p2search' :: Recherche d'informations dans la database.
- CMD :: **!dupe !pre**

-------------------------------------------------------------------------------------------------------
- FLAG 'p2stats' :: Affichage des statistiques depuis la dernière heure. (addpre,delpre,nuke,unnuke...etc)
- CMD :: **!hour**

  -------------------------------------------------------------------------------------------------------
  
CONFiGURATiON DES FLAGS ::

- Premièrement connectez-vous en DCC CHAT avec votre eggdrop
- Ensuite tapper la commande **.chanset #votre-channel +FLAG** (exemple: .chanset #addpre +p2add)
- Et n'oubliez pas de sauvegarder **.save**
- Temps qu'être la pourquoi pas **.rehash** XD

