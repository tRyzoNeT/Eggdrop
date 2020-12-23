PROJET MiGRER VERS LA VERSiON 1.1

- Une mise a jour importante, Connection au serveur mysql 1 seule fois (KEEPMYSQLOPEN).
- Sa accélère considérablement les commandes du eggdrop.
- Le lag est moin vu qu'il a toujours une connection SQL constante.
**OUBLiER CE TCL

# preedb0t.v1.0.FRENCH.LiNUX.EGGDROP.TCL-RyZEN #

Ce qui est nécessaire au bon fonctionnement :: eggdrop - mysqld - mysqltcl

- Chacune des commandes à son propre TCL pour éviter le lag.
- Charger vos TCL sur des eggdrops différents et des serveurs différent.
  - **connexion gbit recommander**
- Assurez-vous d'avoir une base de données MYSQL rapide et performant.
  - **disque dur SSD recommander ou NVME pour de meilleures performances**
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
