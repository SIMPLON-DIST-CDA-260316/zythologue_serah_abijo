-- Création du schéma de la base Zythologue (PostgreSQL)

-- Suppression des tables si elles existent déjà, pour pouvoir relancer le script.
-- On part des tables qui dépendent des autres.
DROP TABLE IF EXISTS biere_ingredient CASCADE;
DROP TABLE IF EXISTS biere_favori CASCADE;
DROP TABLE IF EXISTS biere_avis CASCADE;
DROP TABLE IF EXISTS photo CASCADE;
DROP TABLE IF EXISTS biere CASCADE;
DROP TABLE IF EXISTS ingredient CASCADE;
DROP TABLE IF EXISTS categorie CASCADE;
DROP TABLE IF EXISTS brasserie CASCADE;
DROP TABLE IF EXISTS utilisateur CASCADE;

CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL
);

CREATE TABLE brasserie (
    id_brasserie SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    pays VARCHAR(50) NOT NULL,
    ville VARCHAR(50)
);

CREATE TABLE categorie (
    id_categorie SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE ingredient (
    id_ingredient SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- Une bière est rattachée à une brasserie et une catégorie (les deux obligatoires).
-- On bloque la suppression d'une brasserie ou catégorie encore utilisée.
CREATE TABLE biere (
    id_biere SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    taux_alcool NUMERIC(4,2) NOT NULL CHECK (taux_alcool >= 0),
    prix NUMERIC(6,2) CHECK (prix >= 0),
    id_brasserie INT NOT NULL REFERENCES brasserie(id_brasserie) ON DELETE RESTRICT,
    id_categorie INT NOT NULL REFERENCES categorie(id_categorie) ON DELETE RESTRICT
);

CREATE TABLE photo (
    id_photo SERIAL PRIMARY KEY,
    url VARCHAR(255) NOT NULL,
    id_biere INT NOT NULL REFERENCES biere(id_biere) ON DELETE CASCADE
);

-- L'avis porte une note et un commentaire. Un seul avis par utilisateur et par bière.
CREATE TABLE biere_avis (
    id_avis SERIAL PRIMARY KEY,
    note INT NOT NULL CHECK (note BETWEEN 1 AND 5),
    commentaire TEXT,
    id_utilisateur INT NOT NULL REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    id_biere INT NOT NULL REFERENCES biere(id_biere) ON DELETE CASCADE,
    UNIQUE (id_utilisateur, id_biere)
);

CREATE TABLE biere_favori (
    id_utilisateur INT NOT NULL REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    id_biere INT NOT NULL REFERENCES biere(id_biere) ON DELETE CASCADE,
    PRIMARY KEY (id_utilisateur, id_biere)
);

CREATE TABLE biere_ingredient (
    id_biere INT NOT NULL REFERENCES biere(id_biere) ON DELETE CASCADE,
    id_ingredient INT NOT NULL REFERENCES ingredient(id_ingredient) ON DELETE CASCADE,
    PRIMARY KEY (id_biere, id_ingredient)
);
