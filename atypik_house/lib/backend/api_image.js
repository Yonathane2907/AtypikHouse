const express = require('express');
const router = express.Router();
const db = require('./db');
const multer = require('multer');
const { diskStorage } = require('multer');
const { extname } = require('path');

// Configuration de Multer
const storage = diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

// Route pour l'upload des images et les données du logement
router.post('/upload', upload.single('image'), async (req, res, next) => {
    try {
        const image = req.file;
        const { titre, description, adresse, capacite, nombre_couchage, prix } = req.body;

        if (!image) {
            return res.status(400).json({ message: 'No file uploaded' });
        }

        if (!titre || !description || !adresse || !capacite || !nombre_couchage || !prix) {
            return res.status(400).json({ message: 'Tous les champs sont requis.' });
        }

        const imagePath = `uploads/${image.filename}`;
        const sql =
            `INSERT INTO logement (proprietaire_id, image_path, titre, description, adresse, capacite, nombre_couchage, prix) 
             VALUES (1, ?, ?, ?, ?, ?, ?, ?)`;

        // Exécuter la requête avec `await`
        const [result] = await db.query(sql, [imagePath, titre, description, adresse, capacite, nombre_couchage, prix]);

        res.json({ message: 'Logement ajouté avec succès', imagePath });
    } catch (err) {
        console.error('Database error:', err);
        next(err); // Passer l'erreur au middleware de gestion des erreurs
    }
});

module.exports = router;
