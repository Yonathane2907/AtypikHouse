const express = require('express');
const router = express.Router();
const db = require('./db');
const bcrypt = require('bcryptjs');
// Création d'un compte
router.post('/createAccount', async (req, res) => {
    const { nom, prenom, adresse, email, password, role } = req.body;
    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const [result] = await db.query('INSERT INTO user (nom, prenom, adresse, email, password, role) VALUES (?, ? ,? ,?, ?, ?)', [nom, prenom, adresse, email, hashedPassword, role]);
        res.status(201).json({ message: 'Compte créé avec succès', accountId: result.insertId });
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de la création du compte' });
    }
});

// Mise à jour d'un compte
router.put('/updateAccount/:id_user', async (req, res) => {
    const { id_user } = req.params;
    const { nom, prenom, adresse, email, password, role } = req.body;

    let updateQuery = 'UPDATE user SET';
    const updateParams = [];
    let fieldAdded = false;

    // Ajoute les champs à mettre à jour uniquement s'ils sont fournis
    if (nom) {
        updateQuery += ' nom = ?,';
        updateParams.push(nom);
        fieldAdded = true;
    }
    if (prenom) {
        updateQuery += ' prenom = ?,';
        updateParams.push(prenom);
        fieldAdded = true;
    }
    if (adresse) {
        updateQuery += ' adresse = ?,';
        updateParams.push(adresse);
        fieldAdded = true;
    }
    if (email) {
        updateQuery += ' email = ?,';
        updateParams.push(email);
        fieldAdded = true;
    }
    if (password) {
        // Hache le mot de passe si fourni
        const hashedPassword = await bcrypt.hash(password, 10);
        updateQuery += ' password = ?,';
        updateParams.push(hashedPassword);
        fieldAdded = true;
    }
    if (role) {
        updateQuery += ' role = ?,';
        updateParams.push(role);
        fieldAdded = true;
    }

    // Si aucun champ n'a été ajouté, renvoie une erreur
    if (!fieldAdded) {
        return res.status(400).json({ error: 'Aucun champ à mettre à jour' });
    }

    // Retire la dernière virgule et ajoute la condition WHERE
    updateQuery = updateQuery.slice(0, -1); // Supprime la dernière virgule
    updateQuery += ' WHERE id_user = ?';
    updateParams.push(id_user);

    try {
        await db.query(updateQuery, updateParams);
        res.json({ message: 'Compte mis à jour avec succès' });
    } catch (err) {
        console.error(err); // Log l'erreur pour le débogage
        res.status(500).json({ error: 'Erreur lors de la mise à jour du compte' });
    }
});

// Suppression d'un compte
router.delete('/deleteAccount/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM user WHERE id_user = ?', [id]);
        res.json({ message: 'Compte supprimé avec succès' });
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de la suppression du compte' });
    }
});

// Liste des comptes
router.get('/listAccounts', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT id_user, email, role FROM user');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: 'Erreur lors de la récupération des comptes' });
    }
});

module.exports = router;
