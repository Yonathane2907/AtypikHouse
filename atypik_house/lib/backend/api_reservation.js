const express = require('express');
const router = express.Router();
const db = require('./db');


router.post('/reservation', async (req, res) => {
    const { id_logement, id_user, date_debut, date_fin } = req.body;
    try {
        const result = await db.query('INSERT INTO reservations (id_logement, id_user, date_debut, date_fin) VALUES (?, ?, ?, ?)', [id_logement, id_user, date_debut, date_fin]);
        res.status(201).json({ message: 'Réservation créée avec succès', id_reservation: result.insertId });
    } catch (error) {
        res.status(500).json({ error: 'Erreur lors de la création de la réservation' });
    }
});

router.get('/reservations/:id_user', async (req, res) => {
    const idUser = req.params.id_user; // Récupération de l'id de l'utilisateur depuis l'URL
    const sql = 'SELECT * FROM reservations WHERE id_user = ?'; // Filtrage par id_user
    try {
        const [rows] = await db.query(sql, [idUser]); // Passer l'id_user en paramètre
        res.json(rows); // Renvoie uniquement les réservations de l'utilisateur
    } catch (error) {
        console.error(error); // Pour déboguer l'erreur
        res.status(500).json({ error: 'Erreur lors de la lecture des réservations' });
    }
});


module.exports = router;