# Dictionnaire de données

Ce dictionnaire recense les données gérées par l'application. Pour chaque donnée j'indique son nom, sa description, son type, si elle est obligatoire ou facultative, et la règle associée quand il y en a une.

Les types ici sont des types logiques. Les types PostgreSQL exacts sont fixés dans le MPD.

## Utilisateur

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_utilisateur | Identifiant unique de l'utilisateur | Entier | Oui | Clé primaire |
| prenom | Prénom de l'utilisateur | Texte | Oui | |
| nom | Nom de l'utilisateur | Texte | Oui | |
| email | Adresse email de l'utilisateur | Texte | Oui | Unique |
| mot_de_passe | Mot de passe haché | Texte | Oui | Stocké haché, jamais en clair |

## Brasserie

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_brasserie | Identifiant unique de la brasserie | Entier | Oui | Clé primaire |
| nom | Nom de la brasserie | Texte | Oui | |
| pays | Pays de la brasserie | Texte | Oui | Utilisé pour le tri des bières par pays |
| ville | Ville de la brasserie | Texte | Non | |

## Catégorie

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_categorie | Identifiant unique de la catégorie | Entier | Oui | Clé primaire |
| nom | Nom de la catégorie (IPA, Stout, Lager...) | Texte | Oui | Unique |
| description | Description de la catégorie | Texte | Non | |

## Bière

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_biere | Identifiant unique de la bière | Entier | Oui | Clé primaire |
| nom | Nom de la bière | Texte | Oui | |
| description | Description de la bière | Texte | Non | |
| taux_alcool | Taux d'alcool en pourcentage | Décimal | Oui | Doit être positif ou nul |
| prix | Prix de la bière | Décimal | Non | Doit être positif ou nul si renseigné |
| id_brasserie | Brasserie qui produit la bière | Entier | Oui | Clé étrangère vers Brasserie |
| id_categorie | Catégorie de la bière | Entier | Oui | Clé étrangère vers Catégorie |

## Ingrédient

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_ingredient | Identifiant unique de l'ingrédient | Entier | Oui | Clé primaire |
| nom | Nom de l'ingrédient (malt, houblon...) | Texte | Oui | Unique |

## Photo

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_photo | Identifiant unique de la photo | Entier | Oui | Clé primaire |
| url | Adresse de l'image | Texte | Oui | |
| id_biere | Bière illustrée par la photo | Entier | Oui | Clé étrangère vers Bière |

## Avis (table biere_avis)

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_avis | Identifiant unique de l'avis | Entier | Oui | Clé primaire |
| note | Note attribuée à la bière | Entier | Oui | Comprise entre 1 et 5 |
| commentaire | Commentaire de l'utilisateur | Texte | Non | |
| id_utilisateur | Auteur de l'avis | Entier | Oui | Clé étrangère vers Utilisateur |
| id_biere | Bière concernée par l'avis | Entier | Oui | Clé étrangère vers Bière |

Un même utilisateur ne peut laisser qu'un seul avis par bière. Le couple (id_utilisateur, id_biere) est donc unique.

## Favori (table biere_favori)

Table de liaison entre un utilisateur et une bière.

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_utilisateur | Utilisateur qui enregistre le favori | Entier | Oui | Clé étrangère vers Utilisateur |
| id_biere | Bière enregistrée en favori | Entier | Oui | Clé étrangère vers Bière |

La clé primaire est le couple (id_utilisateur, id_biere), ce qui empêche d'enregistrer deux fois la même bière en favori pour un utilisateur.

## Bière - Ingrédient (table biere_ingredient)

Table de liaison entre une bière et ses ingrédients.

| Donnée | Description | Type | Obligatoire | Règle |
|---|---|---|---|---|
| id_biere | Bière concernée | Entier | Oui | Clé étrangère vers Bière |
| id_ingredient | Ingrédient entrant dans la composition | Entier | Oui | Clé étrangère vers Ingrédient |

La clé primaire est le couple (id_biere, id_ingredient), ce qui évite les doublons d'ingrédient pour une même bière.
