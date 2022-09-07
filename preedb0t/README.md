# preedb0t.*.FRENCH.LiNUX.EGGDROP.TCL-RyZEN #

Les versions preedb0t.1.x sont à present dans _archives/

Ce qui est nécessaire au bon fonctionnement :: eggdrop - mysqld - mysqltcl ( fichier de configuration preed.tcl )

- Chacune des commandes à son propre TCL pour éviter le lag.
- Charger vos TCL sur des eggdrops différents et des serveurs différent.
  - **connexion gbit recommander**
- Assurez-vous d'avoir une base de données MYSQL rapide et performant.
  - **disque dur SSD recommander ou NVME pour de meilleures performances**
  -------------------------------------------------------------------------------------------------------

**VERSiON 1.0 ?! :** 
 - J'ai personnelement arrêter de coder cette version, il y a trop de LAG. Une connexion au serveur mySQLd sur chaque commande... Régler avec la version 1.1 XD

**QUOi DE NOUVEAU?!? DANS LA VERSiON 1.1 :**

- TCL garde toujours une connexion 'OUVERTE' au serveur mySQLd (KEEPMYSQLOPEN).
- Sa accélère considérablement TOUTE les commandes du eggdrop.
- Le LAG est beaucoup moin vu qu'il y a toujours une connection 'OUVERTE' au serveur mySQLd.

  -------------------------------------------------------------------------------------------------------

**LA VERSiON 2.0?!?**

- Le code est revu entierement pour être optimiser avec TCL 1.6+ et eggdrop 1.9+
- Simplification & Re-Structuration du code, accélère doublement les commandes du eggdrop et éviter des bugs dans le futur...
- La connexion MySQL reste ouverte pour accelerer les access a celle-ci et avoir un gain de réponse accru au commandes.
