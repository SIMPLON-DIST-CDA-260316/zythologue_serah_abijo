# Correction par pair

**Correcteur :** Serah Abijo
**Projet corrigé :** Anaïs Cieslar (`zythologue_anais_cieslar`)

## Prise en main du projet

J'ai cloné le repo et tout était clair direct. Le README explique bien comment
lancer, et les étapes sont simples à suivre. J'ai bien aimé que tu dises
toi-même ce qui n'est pas encore fini, ça aide.

## Docker

Ça marche bien avec `docker compose up -d`. J'ai juste mis le port en 5434 dans
mon `.env` parce que le 5432 était déjà pris sur mon ordi, mais c'est ce que tu
expliques dans le README donc c'était simple.

## PostgreSQL / DBeaver

Connexion ok avec les infos du `.env`, je les ai trouvées facilement. La base
se crée bien.

## Fichiers SQL

Le schéma se crée sans erreur et ton seed est super complet, y'a plein de
brasseries et de bières pour tester. J'ai vu que t'avais déjà fait des bonus
(les created_at et les triggers sur les photos), bien joué.

Un truc si tu veux améliorer : quand j'ai relancé le `01_create_schema.sql` une
2e fois j'ai eu des erreurs "relation already exists". Si tu mets des
`DROP TABLE IF EXISTS ... CASCADE` au début, tu pourras le relancer sans souci.

## Remarques générales

Facile à reprendre. Le seul truc que j'ajouterais c'est les DROP au début du
schéma pour pouvoir le relancer. Sinon le reste est bon. GG Anaïs C !
