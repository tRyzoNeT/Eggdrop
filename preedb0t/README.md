# preedb0t.*.FRENCH.LiNUX.EGGDROP.TCL-RyZEN #

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

  -------------------------------------------------------------------------------------------------------
