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

// Route pour l'upload des images
router.post('/upload', upload.single('image'), (req, res) => {
    const image = req.file;
    if (!image) {
        return res.status(400).json({ message: 'No file uploaded' });
    }

    // Enregistre le chemin de l'image dans la base de données
    const imagePath = `uploads/${image.filename}`;
    const sql = "INSERT INTO logement (proprietaire_id, image_path, titre, description, adresse, capacite, nombre_couchage, prix) VALUES (1,?,'titre', 'description', 'adresse', 'capacite', 'nombre_couchage', 'prix')";

    db.query(sql, [imagePath], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ message: 'Database error' });
        }
        res.json({ message: 'Image uploaded successfully', imagePath });
    });
});

module.exports = router;
