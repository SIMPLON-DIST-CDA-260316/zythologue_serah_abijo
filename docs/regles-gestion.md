# Règles de gestion

Les règles de gestion décrivent le fonctionnement métier de l'application. Ce sont elles qui justifient les entités, les associations et les cardinalités du modèle.

## Brasseries et bières

Une brasserie peut produire plusieurs bières, ou aucune.
Une bière est produite par une seule brasserie.
Une bière doit obligatoirement être rattachée à une brasserie.

## Catégories

Une catégorie peut regrouper plusieurs bières, ou aucune.
Une bière appartient à une seule catégorie.
Une bière doit obligatoirement avoir une catégorie.

## Ingrédients

Une bière peut être composée de plusieurs ingrédients.
Un ingrédient peut entrer dans la composition de plusieurs bières.

## Photos

Une bière peut être illustrée par plusieurs photos, ou aucune.
Une photo illustre une seule bière.
Une photo est supprimée si la bière qu'elle illustre est supprimée.

## Utilisateurs

Un utilisateur doit renseigner un prénom, un nom, un email et un mot de passe.
Un utilisateur est identifié de façon unique par son email.
Le mot de passe d'un utilisateur est stocké sous forme hachée, jamais en clair.

## Avis

Un avis est rédigé par un seul utilisateur.
Un avis concerne une seule bière.
Un avis contient une note et un commentaire.
Un utilisateur peut rédiger plusieurs avis sur des bières différentes.
Une bière peut recevoir plusieurs avis, ou aucun.
Un utilisateur ne peut rédiger qu'un seul avis par bière.
La note d'un avis est comprise entre 1 et 5.
Un avis est supprimé si son utilisateur ou sa bière est supprimé.

## Favoris

Un utilisateur peut ajouter plusieurs bières à ses favoris.
Une bière peut être ajoutée en favori par plusieurs utilisateurs.
Un utilisateur ne peut ajouter une même bière en favori qu'une seule fois.
Un favori est supprimé si son utilisateur ou sa bière est supprimé.

## Caractéristiques des bières

Une bière doit avoir un nom.
Le taux d'alcool d'une bière est positif ou nul.
Le prix d'une bière est positif ou nul lorsqu'il est renseigné.

## Synthèse des cardinalités

| Association | Cardinalités | Traduction |
|---|---|---|
| Brasserie produit Bière | (0,n) / (1,1) | clé étrangère brasserie dans biere |
| Catégorie classe Bière | (0,n) / (1,1) | clé étrangère categorie dans biere |
| Bière illustrée par Photo | (0,n) / (1,1) | clé étrangère biere dans photo |
| Bière composée d'Ingrédient | (0,n) / (0,n) | table de liaison biere_ingredient |
| Utilisateur note Bière | (0,n) / (0,n) avec données | table biere_avis |
| Utilisateur favorise Bière | (0,n) / (0,n) | table de liaison biere_favori |

## Hypothèses retenues

Une bière n'a qu'une seule catégorie principale. On pourrait gérer plusieurs catégories par bière, mais ça ajouterait une table de liaison sans réel besoin ici.

La catégorie est obligatoire pour que chaque bière soit classable. Sinon la requête qui compte les bières par catégorie serait faussée.

Les ingrédients sont gérés par leur simple présence dans une bière. Je ne gère pas la quantité ou la proportion.

Quand une bière est supprimée, ses photos, ses avis et ses favoris le sont aussi, parce qu'ils n'existent pas sans elle. À l'inverse, on ne peut pas supprimer une brasserie ou une catégorie tant que des bières y sont rattachées, pour ne pas se retrouver avec des bières orphelines.
