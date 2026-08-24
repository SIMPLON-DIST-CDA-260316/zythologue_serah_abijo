import pool from '../db.js';

function formaterBiere(biere) {
  if (!biere) {
    return undefined;
  }
  return {
    ...biere,
    taux_alcool: Number(biere.taux_alcool),
    prix: biere.prix === null ? null : Number(biere.prix),
  };
}

export async function getBiereById(id) {
  const result = await pool.query(
    'SELECT * FROM biere WHERE id_biere = $1',
    [id]
  );
  return formaterBiere(result.rows[0]);
}

export async function createBiere(donnees) {
  const { nom, description, taux_alcool, prix, id_brasserie, id_categorie } = donnees;
  const result = await pool.query(
    `INSERT INTO biere (nom, description, taux_alcool, prix, id_brasserie, id_categorie)
     VALUES ($1, $2, $3, $4, $5, $6)
     RETURNING *`,
    [nom, description ?? null, taux_alcool, prix ?? null, id_brasserie, id_categorie]
  );
  return formaterBiere(result.rows[0]);
}

export async function updateBiere(id, donnees) {
  const { nom, description, taux_alcool, prix, id_brasserie, id_categorie } = donnees;
  const result = await pool.query(
    `UPDATE biere
     SET nom = $1, description = $2, taux_alcool = $3, prix = $4, id_brasserie = $5, id_categorie = $6
     WHERE id_biere = $7
     RETURNING *`,
    [nom, description ?? null, taux_alcool, prix ?? null, id_brasserie, id_categorie, id]
  );
  return formaterBiere(result.rows[0]);
}

export async function deleteBiere(id) {
  const result = await pool.query(
    'DELETE FROM biere WHERE id_biere = $1 RETURNING id_biere',
    [id]
  );
  return result.rows[0];
}
