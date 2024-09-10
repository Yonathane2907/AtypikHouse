const express = require('express');
const router = express.Router();
const db = require('./db');

router.get('/getLogements', async (req, res) => {

    try {

        const [rows] = await db.query('SELECT * FROM typelogement');

        res.json(rows);

    } catch (err) {
        console.error('Erreur lors de la récupération des logements:', err);

        res.status(500).json({ error: 'Erreur lors de la récupération des logements' });

    }

});
module.exports=router;