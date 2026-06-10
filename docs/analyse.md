# Analyse du besoin

## Contexte

Une entreprise spécialisée dans la promotion des bières artisanales veut développer une application web et mobile pour une communauté d'amateurs. L'application doit permettre de découvrir des bières, de consulter des informations sur les brasseries, les ingrédients et les caractéristiques des produits, d'enregistrer ses bières favorites et de partager des avis.

Avant de développer l'application, il faut une base de données pour structurer ces informations. Mon travail ici consiste à analyser le besoin, repérer les données à gérer et concevoir un modèle de données cohérent.

## Besoins fonctionnels

L'application doit pouvoir :

- présenter un catalogue de bières avec leurs caractéristiques (nom, description, taux d'alcool, prix) ;
- rattacher chaque bière à la brasserie qui la produit ;
- classer chaque bière dans une catégorie (IPA, Stout, Lager...) ;
- décrire la composition des bières avec une liste d'ingrédients ;
- associer une ou plusieurs photos à une bière ;
- gérer des comptes utilisateurs ;
- laisser les utilisateurs noter et commenter les bières ;
- laisser les utilisateurs mettre des bières en favori.

## Objets métier

Les objets qui ressortent du besoin, et qui deviennent les entités du modèle :

- Utilisateur : une personne inscrite sur l'application.
- Bière : le produit central.
- Brasserie : l'établissement qui produit les bières.
- Catégorie : la famille d'une bière.
- Ingrédient : un composant d'une bière.
- Photo : une image d'une bière.
- Avis : la note et le commentaire qu'un utilisateur laisse sur une bière.
- Favori : le lien entre un utilisateur et une bière qu'il a enregistrée.

## Relations principales

- Une brasserie produit des bières.
- Une bière appartient à une catégorie.
- Une bière est composée de plusieurs ingrédients (plusieurs à plusieurs).
- Une bière peut avoir plusieurs photos.
- Un utilisateur écrit des avis sur des bières.
- Un utilisateur met des bières en favori (plusieurs à plusieurs).

Le détail des cardinalités est dans les règles de gestion.

## Périmètre

Le projet porte seulement sur la conception et l'implémentation de la base de données. Le développement de l'application n'en fait pas partie.

J'ai volontairement laissé de côté quelques points pour rester dans le périmètre demandé :

- la gestion des commandes, des paiements et des stocks ;
- la quantité de chaque ingrédient dans une bière ;
- la gestion détaillée des rôles et des droits utilisateurs ;
- la localisation des brasseries au-delà du pays et de la ville.

Ces points pourraient être ajoutés plus tard si le besoin évolue.

## Choix structurants

Deux choix orientent tout le modèle. Ils sont justifiés dans les règles de gestion :

- une bière est rattachée à une seule catégorie et à une seule brasserie, les deux obligatoires ;
- un utilisateur ne peut laisser qu'un seul avis et qu'un seul favori par bière, pour éviter les doublons.
