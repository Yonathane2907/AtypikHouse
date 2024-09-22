const express = require('express');
const router = express.Router();
const db = require('./db');
// Endpoint pour sélectionner tous les logements
router.get('/getLogements', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM logement');
        res.json(rows);
    } catch (err) {
        console.error('Erreur lors de la sélection des logements:', err);
        res.status(500).json({ error: 'Erreur lors de la sélection des logements' });
    }
});

router.get('/logements/:id/commentaires', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await db.execute('SELECT * FROM commentaires WHERE id_logement = ?', [id]);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de la récupération des commentaires' });
        console.log(err);
    }
});

// Ajouter un commentaire
router.post('/logements/:id/commentaires', async (req, res) => {
    const { id } = req.params;
    const { auteur, contenu } = req.body;
    try {
        await db.execute('INSERT INTO commentaires (id_logement, auteur, contenu) VALUES (?, ?, ?)', [id, auteur, contenu]);
        res.status(201).json({ message: 'Commentaire ajouté avec succès' });
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de l\'ajout du commentaire' });
    }
});

router.get('/logements/:proprietaire_id', async (req, res) => {
    const { proprietaire_id } = req.params;

    try {
        const sql = `SELECT * FROM logement WHERE proprietaire_id = ?`;
        const [logements] = await db.query(sql, [proprietaire_id]);

        res.json(logements);
    } catch (err) {
        console.error('Database error:', err);
        res.status(500).json({ message: 'Erreur lors de la récupération des logements.' });
    }
});

router.get('/proprietaire/:user_id', async (req, res) => {
    const { user_id } = req.params;
    try {
        const [rows] = await db.query('SELECT id_proprietaire FROM proprietaire WHERE user_id = ?', [user_id]);

        if (rows.length === 0) {
            return res.status(404).json({ error: 'Propriétaire non trouvé pour cet utilisateur.' });
        }

        res.json(rows[0]); // Retourne le proprietaire_id
    } catch (err) {
        console.error('Erreur lors de la récupération du propriétaire:', err);
        res.status(500).json({ error: 'Erreur lors de la récupération du propriétaire' });
    }
});

module.exports = router;