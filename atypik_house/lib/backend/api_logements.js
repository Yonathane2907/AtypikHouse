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

module.exports = router;