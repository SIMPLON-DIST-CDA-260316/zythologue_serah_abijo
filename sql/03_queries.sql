-- Requêtes demandées

-- 1. Lister les bières par taux d'alcool croissant
SELECT nom, taux_alcool
FROM biere
ORDER BY taux_alcool ASC;

-- 2. Afficher le nombre de bières par catégorie
SELECT c.nom AS categorie, COUNT(b.id_biere) AS nb_bieres
FROM categorie c
LEFT JOIN biere b ON b.id_categorie = c.id_categorie
GROUP BY c.nom
ORDER BY nb_bieres DESC;

-- 3. Trouver toutes les bières d'une brasserie donnée
SELECT b.nom, b.taux_alcool, b.prix
FROM biere b
JOIN brasserie br ON br.id_brasserie = b.id_brasserie
WHERE br.nom = 'Brasserie du Mont';

-- 4. Lister les utilisateurs et le nombre de bières ajoutées à leurs favoris
SELECT u.prenom, u.nom, COUNT(f.id_biere) AS nb_favoris
FROM utilisateur u
LEFT JOIN biere_favori f ON f.id_utilisateur = u.id_utilisateur
GROUP BY u.id_utilisateur, u.prenom, u.nom
ORDER BY nb_favoris DESC;

-- 5. Ajouter une nouvelle bière
INSERT INTO biere (nom, description, taux_alcool, prix, id_brasserie, id_categorie)
VALUES ('Mont Saison', 'Nouvelle saison maison', 5.8, 4.20, 1, 8);

-- 6. Afficher les bières avec leur brasserie, triées par pays
SELECT b.nom AS biere, br.nom AS brasserie, br.pays
FROM biere b
JOIN brasserie br ON br.id_brasserie = b.id_brasserie
ORDER BY br.pays, b.nom;

-- 7. Lister les bières avec leurs ingrédients
SELECT b.nom AS biere, STRING_AGG(i.nom, ', ' ORDER BY i.nom) AS ingredients
FROM biere b
JOIN biere_ingredient bi ON bi.id_biere = b.id_biere
JOIN ingredient i ON i.id_ingredient = bi.id_ingredient
GROUP BY b.nom
ORDER BY b.nom;

-- 8. Afficher les brasseries produisant plus de cinq bières
SELECT br.nom, COUNT(b.id_biere) AS nb_bieres
FROM brasserie br
JOIN biere b ON b.id_brasserie = br.id_brasserie
GROUP BY br.id_brasserie, br.nom
HAVING COUNT(b.id_biere) > 5;

-- 9. Lister les bières qui ne figurent dans aucun favori
SELECT b.nom
FROM biere b
LEFT JOIN biere_favori f ON f.id_biere = b.id_biere
WHERE f.id_biere IS NULL;

-- 10. Trouver les bières favorites communes entre deux utilisateurs (ici 1 et 2)
SELECT b.nom
FROM biere b
JOIN biere_favori f1 ON f1.id_biere = b.id_biere AND f1.id_utilisateur = 1
JOIN biere_favori f2 ON f2.id_biere = b.id_biere AND f2.id_utilisateur = 2;

-- 11. Afficher les brasseries dont les bières ont une moyenne de notes supérieure à 4
SELECT br.nom, ROUND(AVG(a.note), 2) AS moyenne_notes
FROM brasserie br
JOIN biere b ON b.id_brasserie = br.id_brasserie
JOIN biere_avis a ON a.id_biere = b.id_biere
GROUP BY br.id_brasserie, br.nom
HAVING AVG(a.note) > 4;

-- 12. Mettre à jour les informations d'une brasserie
UPDATE brasserie
SET ville = 'Villeurbanne'
WHERE nom = 'Brasserie du Mont';

-- 13. Supprimer les photos d'une bière donnée (ici la bière 1)
DELETE FROM photo
WHERE id_biere = 1;
