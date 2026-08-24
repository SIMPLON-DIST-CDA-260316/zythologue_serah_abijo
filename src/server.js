import express from 'express';
import pool from './db.js';
import {
  getBiereById,
  createBiere,
  updateBiere,
  deleteBiere,
} from './services/biere.js';

const app = express();
app.use(express.json());

function validerCorpsBiere(corps) {
  const { nom, taux_alcool, prix, id_brasserie, id_categorie } = corps;

  if (typeof nom !== 'string' || nom.trim() === '') {
    return 'Le nom est obligatoire';
  }
  if (typeof taux_alcool !== 'number' || taux_alcool < 0) {
    return "Le taux d'alcool doit être un nombre positif ou nul";
  }
  if (prix !== undefined && prix !== null && (typeof prix !== 'number' || prix < 0)) {
    return 'Le prix doit être un nombre positif ou nul';
  }
  if (!Number.isInteger(id_brasserie)) {
    return 'id_brasserie est obligatoire et doit être un entier';
  }
  if (!Number.isInteger(id_categorie)) {
    return 'id_categorie est obligatoire et doit être un entier';
  }
  return null;
}

app.get('/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ status: 'ok' });
  } catch (error) {
    res.status(503).json({ status: 'error', message: 'base injoignable' });
  }
});

app.get('/bieres/:id', async (req, res) => {
  const id = Number(req.params.id);
  if (!Number.isInteger(id) || id < 1) {
    return res.status(400).json({ message: 'id invalide' });
  }
  const biere = await getBiereById(id);
  if (!biere) {
    return res.status(404).json({ message: 'Bière non trouvée' });
  }
  res.json(biere);
});

app.post('/bieres', async (req, res) => {
  const erreur = validerCorpsBiere(req.body);
  if (erreur) {
    return res.status(400).json({ message: erreur });
  }
  try {
    const biere = await createBiere(req.body);
    res.status(201).json(biere);
  } catch (error) {
    if (error.code === '23503') {
      return res.status(400).json({ message: 'Brasserie ou catégorie inexistante' });
    }
    throw error;
  }
});

app.put('/bieres/:id', async (req, res) => {
  const id = Number(req.params.id);
  if (!Number.isInteger(id) || id < 1) {
    return res.status(400).json({ message: 'id invalide' });
  }
  const erreur = validerCorpsBiere(req.body);
  if (erreur) {
    return res.status(400).json({ message: erreur });
  }
  try {
    const biere = await updateBiere(id, req.body);
    if (!biere) {
      return res.status(404).json({ message: 'Bière non trouvée' });
    }
    res.json(biere);
  } catch (error) {
    if (error.code === '23503') {
      return res.status(400).json({ message: 'Brasserie ou catégorie inexistante' });
    }
    throw error;
  }
});

app.delete('/bieres/:id', async (req, res) => {
  const id = Number(req.params.id);
  if (!Number.isInteger(id) || id < 1) {
    return res.status(400).json({ message: 'id invalide' });
  }
  const supprimee = await deleteBiere(id);
  if (!supprimee) {
    return res.status(404).json({ message: 'Bière non trouvée' });
  }
  res.status(204).end();
});

app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ message: 'Erreur serveur' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Serveur démarré sur http://localhost:${PORT}`);
});
