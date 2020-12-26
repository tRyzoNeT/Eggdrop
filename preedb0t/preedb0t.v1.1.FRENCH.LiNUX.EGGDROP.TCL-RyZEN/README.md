# preedb0t.v1.1.FRENCH.LiNUX.EGGDROP.TCL-RyZEN

Ce qui est nécessaire au bon fonctionnement :: eggdrop - mysqld - mysqltcl

- Chacune des commandes à son propre TCL pour éviter le lag.
- Charger vos TCL sur des eggdrops différents et des serveurs différent.
  - **connexion gbit recommander**
- Assurez-vous d'avoir une base de données MYSQL rapide et performant.
  - **disque dur SSD recommander ou NVME pour de meilleures performances**
  -------------------------------------------------------------------------------------------------------

QUOi DE NOUVEAU?!? DANS LA VERSiON 1.1

- TCL garde toujours une connexion 'OUVERTE' au serveur mySQLd (KEEPMYSQLOPEN).
- Sa accélère considérablement TOUTE les commandes du eggdrop.
- Le LAG est beaucoup moin vu qu'il y a toujours une connection 'OUVERTE' au serveur mySQLd.

# TCL complet a 80%
  -------------------------------------------------------------------------------------------------------
  
iNDEX de nos FLAGS :: **ADD - DB - SEARCH - STATS**

- FLAG 'ADD' :: Ajouter à la database toute information possible
- CMD :: **!addnfoname !addpre !addsfvname !addurl !info !readd**
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
CONFiGURATiON FLAGS

- Premièrement connectez-vous en DCC CHAT avec votre eggdrop
- Ensuite tapper la commande **.chanset #votre-channel +FLAG** (exemple: .chanset #addpre +ADD)
- Et n'oubliez pas de sauvegarder **.save**
