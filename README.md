### ÉVALUATION D’ENTRAÎNEMENT :
## Créer et administrer une base de données
### GDWFSCAUBDDEXAIII2A

Ceci est une base de données fictives pour les besoins d'un groupe de cinéma. 

*Le diagramme UML se trouve dans le dossier portant le même nom.*

**La base de donnée à été développer avec MySQL 
Si vous utilisez un SGBD différent, certaines fonctionnalités rencontreront peut-être des problèmes.**

Pour importer la base de donnée stockée dans les fichiers .sql, en ligne de commande, suivez les instructions :

- Ouvrez MySQL Shell
- Tapez ```\sql``` pour passer en mode sql (si vous souhaitez éffectuer des requêtes ultérieurement)
- Connectez-vous à votre localhost : ```\connect root@localhost:3306``` (Le service Mysql sur le port 3306 doit être actif), modifiez la commande si nécessaire pour changer l'utilisateur ou le port.
- Entrez votre mot de passe et continuez
- Tapez ensuite ``` \source <chemin\du\fichier.sql>``` ; exemple : ```\source C:\Users\Me\Desktop\script.sql```
- Importez dabord le fichier database.sql pour importer la structure. Vous pourrez ensuite importer les données qui se trouvent dans le fichier data.sql

En cas de malfonction si vous importez le script sur un autre SGBD qui ne prend pas en charge certaines fonctionnalités, vous pouvez supprimer les conditions (partie en dessous du marqueur /* --- */ ).

Pour procéder à une sauvegarde de la structure de la base de données et de ses données, vous pouvez suivre les instructions ci dessous :

- MySQL doit être référencer dans les variables d'environnement systèmes (PATH) de votre machine.
- Ouvrez l'invite de commande de l'OS.
- Rendez-vous dans le dossier désiré pour la sauvegarde du fichier
- Entrez la commande : ``` mysqldump -u root -p !nomDeLaBase! > datadump.sql ```
- Modifiez la !valeur! par le nom de la base de donnée. Par Défaut : ``` mydatabase ```
- Entrez le mot de passe de votre utilisateur pour valider l'extraction.

- L'importation des données peut être éffectuée en utilisant la commande inverse :
``` mysql -u root -p !nomDeLaBase! < datadump.sql```


## Utilisation

Pour ajouter une **réservation manuellement**, se référencer au fichier data.sql.
Il faudra ajouter une colonne à jonction_reservation, portant l'ID de la réservation, l'ID du type de tarif, et le nombre de places payées avec ce tarif, par exemple : ```(3, 1, 2)``` 

Ceci signifie que l'ID de la réservation est 3 ; l'ID du type de tarif est 1 (Tarif Plein); et le nombre de places sélectioner est 2.
Faire coincider avec le nombre total de places à acheter pour cette réservation (reservations.nb_places).
Le fait d'ajouter des valeurs dans la table jonctions_reservations, déclenche les triggers, lesquels **calcul le montant total de la réservation du client**.
Remarque : Avec une Application, les données seraient entrées automatiquement.

Il est impossible de supprimer une séance si des réservations existent pour celle-ci, ni de supprimer les données de la table jointure_reservation pendent que la réservation liée est gardée en base de données.

Le type de paiement est défini par un boolean. L'accueil d'un cinéma pourra rapidement vérifier si le client à déja **payer en ligne** ou non.

La mise en place d'utilisateurs ayant des accés restreints ou des vues sur l'ensemble de la base de données devrait être définie sur le système de SGBD utilisé pour le déploiement par le groupe, et ainsi relier les utilisateurs SQL avec des privilèges aux utilisateurs voulus dans le cadre des rôles stockés en base de données.

Je vous remercie de trouver ci après les fichiers .sql.
Vous pouvez aussi trouver mon fichier test.txt, lequel m'a permis de valider le fonctionnement de mon travail étapes par étapes.
