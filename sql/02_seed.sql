-- Données de test pour la base Zythologue

-- On vide les tables et on remet les compteurs à 1 pour pouvoir relancer le script.
TRUNCATE TABLE biere_ingredient, biere_favori, biere_avis, photo,
               biere, ingredient, categorie, brasserie, utilisateur
RESTART IDENTITY CASCADE;

-- Utilisateurs (le mot de passe est une valeur hachée, pas le mot de passe en clair)
INSERT INTO utilisateur (prenom, nom, email, mot_de_passe) VALUES
('Serah', 'Abijo',   'serah@mail.com', '$2b$10$wH8Qmf3kZ1pX7vYbN0eauOQ2sJrLd9cT6gFhPiKxUyVwZaBcDeFg'),
('Lucas', 'Martin',  'lucas@mail.com', '$2b$10$K3pLm9TqRsVnB2cXdZ8aOe5uJwHfGiYkPlQrStUvWxYzAbCdEfGh'),
('Emma',  'Bernard', 'emma@mail.com',  '$2b$10$Zx4Wv7Ts6Rq5Po3Nm2LkOeJiHgFdScVbBnMaPlQoIuYtReWqAzSx'),
('Hugo',  'Petit',   'hugo@mail.com',  '$2b$10$aQwErTyUiOpAsDfGhJkLzOxCvBnMqWeRtYuIoPaSdFgHjKlZxCvB'),
('Chloé', 'Durand',  'chloe@mail.com', '$2b$10$mNbVcXz1234QwErTyUiOpEaSdFgHjKlPoIuYtReWqAzXsCdVfBgN');

-- Brasseries (plusieurs pays pour pouvoir trier par pays)
INSERT INTO brasserie (nom, pays, ville) VALUES
('Brasserie du Mont', 'France',      'Lyon'),
('La Binouze',        'France',      'Lille'),
('Highland Brew',     'Royaume-Uni', 'Édimbourg'),
('Brasserie d''Orval','Belgique',    'Orval'),
('Bavaria Bräu',      'Allemagne',   'Munich');

-- Catégories (styles de bière)
INSERT INTO categorie (nom, description) VALUES
('IPA',     'Bière houblonnée et amère'),
('Stout',   'Bière noire torréfiée'),
('Pilsner', 'Lager blonde et sèche'),
('Triple',  'Bière belge forte'),
('Blanche', 'Bière de froment légère'),
('Porter',  'Bière brune maltée'),
('Lager',   'Bière blonde de fermentation basse'),
('Saison',  'Bière artisanale belge épicée');

-- Ingrédients
INSERT INTO ingredient (nom) VALUES
('Eau'),
('Malt d''orge'),
('Houblon'),
('Levure'),
('Froment'),
('Coriandre'),
('Écorce d''orange'),
('Avoine');

-- Bières. La Brasserie du Mont en a 6, pour tester la requête
-- "brasseries produisant plus de 5 bières".
INSERT INTO biere (nom, description, taux_alcool, prix, id_brasserie, id_categorie) VALUES
('Mont IPA',        'IPA maison',            6.5, 4.50, 1, 1),
('Mont Stout',      'Stout torréfié',        7.2, 5.00, 1, 2),
('Mont Blonde',     'Blonde légère',         5.0, 3.80, 1, 7),
('Mont Triple',     'Triple puissante',      8.5, 5.50, 1, 4),
('Mont Blanche',    'Blanche au froment',    4.8, 4.00, 1, 5),
('Mont Porter',     'Porter au malt',        6.0, 4.80, 1, 6),
('Binouze Pils',    'Pilsner du Nord',       4.5, 3.20, 2, 3),
('Binouze Saison',  'Saison épicée',         6.2, 4.60, 2, 8),
('Highland Stout',  'Stout écossais',        8.0, 6.00, 3, 2),
('Highland IPA',    'IPA écossaise',         6.8, 5.20, 3, 1),
('Orval Triple',    'Triple belge',          9.0, 6.50, 4, 4),
('Orval Blonde',    'Blonde belge',          6.2, 5.00, 4, 7),
('Bavaria Helles',  'Lager de Munich',       5.2, 3.90, 5, 7);

-- Photos (plusieurs sur certaines bières)
INSERT INTO photo (url, id_biere) VALUES
('https://images.zytho/mont-ipa-1.jpg',     1),
('https://images.zytho/mont-ipa-2.jpg',     1),
('https://images.zytho/mont-stout.jpg',     2),
('https://images.zytho/highland-stout.jpg', 9);

-- Avis (note de 1 à 5)
INSERT INTO biere_avis (note, commentaire, id_utilisateur, id_biere) VALUES
(5, 'Excellente IPA',         1, 1),
(4, 'Très bonne',             2, 1),
(4, 'Bien torréfiée',         1, 2),
(5, 'Ma préférée',            3, 2),
(5, 'Puissante et ronde',     2, 4),
(5, 'Magnifique stout',       1, 9),
(5, 'Incroyable',             4, 9),
(2, 'Trop légère à mon goût', 2, 7),
(3, 'Correcte',               3, 7),
(5, 'Triple parfaite',        1, 11),
(4, 'Très bonne triple',      3, 11),
(3, 'Sympa sans plus',        4, 13);

-- Favoris. Chloé n'en a aucun. La bière 1 est commune à Serah et Lucas,
-- la bière 9 est commune à Serah et Emma.
INSERT INTO biere_favori (id_utilisateur, id_biere) VALUES
(1, 1),
(1, 2),
(1, 9),
(2, 1),
(2, 4),
(3, 9),
(3, 11),
(4, 13);

-- Composition des bières en ingrédients
INSERT INTO biere_ingredient (id_biere, id_ingredient) VALUES
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 8),
(3, 1), (3, 2), (3, 3), (3, 4),
(4, 1), (4, 2), (4, 3), (4, 4),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7),
(6, 1), (6, 2), (6, 3), (6, 4),
(7, 1), (7, 2), (7, 3), (7, 4),
(8, 1), (8, 2), (8, 3), (8, 4),
(9, 1), (9, 2), (9, 3), (9, 4), (9, 8),
(10, 1), (10, 2), (10, 3), (10, 4),
(11, 1), (11, 2), (11, 3), (11, 4),
(12, 1), (12, 2), (12, 3), (12, 4),
(13, 1), (13, 2), (13, 3), (13, 4);
