# API Zythologue

Petite API REST pour gérer les bières de la base Zythologue. Tout se passe en JSON.

## Lancer

Avec Docker :

```bash
docker compose up -d --build
```

Si le port 3000 est déjà utilisé :

```bash
API_PORT=3001 docker compose up -d --build
```

Sans dockeriser l'API, on peut aussi lancer seulement la base puis :

```bash
npm install
npm run dev
```

L'API écoute sur `http://localhost:3000` par défaut. La connexion à la base vient
du `.env` en local, ou de `DATABASE_URL` quand l'API tourne dans Docker.

## Les champs d'une bière

Utilisés par la création et la modification :

- `nom` : texte, obligatoire
- `taux_alcool` : nombre ≥ 0, obligatoire
- `prix` : nombre ≥ 0, optionnel
- `description` : texte, optionnel
- `id_brasserie` : entier, obligatoire (la brasserie doit déjà exister)
- `id_categorie` : entier, obligatoire (la catégorie doit déjà exister)

## Endpoints

### GET /bieres/:id

Renvoie une bière à partir de son id.

- 200 : la bière
- 400 : id qui n'est pas un entier
- 404 : aucune bière avec cet id

```bash
curl http://localhost:3000/bieres/1
```

```json
{ "id_biere": 1, "nom": "Mont IPA", "description": "IPA maison", "taux_alcool": 6.5, "prix": 4.5, "id_brasserie": 1, "id_categorie": 1 }
```

### POST /bieres

Crée une bière (voir les champs plus haut).

- 201 : bière créée, renvoyée avec son id
- 400 : corps invalide, ou brasserie/catégorie inexistante

```bash
curl -X POST http://localhost:3000/bieres \
  -H "Content-Type: application/json" \
  -d '{"nom":"Mont Saison","taux_alcool":5.8,"prix":4.2,"id_brasserie":1,"id_categorie":8}'
```

### PUT /bieres/:id

Modifie une bière. Remplacement complet : on envoie tous les champs, comme pour la création. Un champ optionnel omis (description, prix) repasse à null.

- 200 : bière modifiée
- 400 : id ou corps invalide, ou brasserie/catégorie inexistante
- 404 : aucune bière avec cet id

```bash
curl -X PUT http://localhost:3000/bieres/14 \
  -H "Content-Type: application/json" \
  -d '{"nom":"Mont Saison","description":"Version revisitee","taux_alcool":6,"prix":4.5,"id_brasserie":1,"id_categorie":8}'
```

### DELETE /bieres/:id

Supprime une bière. Ses photos, avis et favoris sont supprimés avec (cascade définie dans le schéma).

- 204 : supprimée, rien n'est renvoyé
- 400 : id invalide
- 404 : aucune bière avec cet id

```bash
curl -X DELETE http://localhost:3000/bieres/14
```

## /health

Vérifie que l'API répond et qu'elle joint la base. Pas demandé par le brief, juste pratique pour le diagnostic.

```bash
curl http://localhost:3000/health
```
