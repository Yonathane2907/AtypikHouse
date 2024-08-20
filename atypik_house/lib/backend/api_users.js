const express = require('express');
const router = express.Router();
const db = require('./db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Endpoint pour récupérer tous les utilisateurs
router.get('/getUsers', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM user');
        res.json(rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des utilisateurs:', err);
        res.status(500).json({ error: 'Erreur lors de la récupération des utilisateurs' });
    }
});

//Endpoint d'inscription
router.post('/signUp', async (req, res) => {
    console.log(req.body);
    const { nom, prenom, adresse, email, password } = req.body; // Récupérer les données du corps de la requête
    const hashedPassword = await bcrypt.hash(password, 10);
    try {
        const [rows] = await db.query(
            'INSERT INTO `user` (`nom`, `prenom`, `adresse`, `email`, `password`)' +
            ' VALUES (?, ?, ?, ?, ?)', // Utilisation de placeholders pour éviter les injections SQL
            [nom, prenom, adresse, email, hashedPassword]
        );
        res.json(rows); // Renvoyer les données insérées si nécessaire
    } catch (err) {
        console.error('Erreur lors de l\'inscription', err);
        res.status(500).json({ error: 'Erreur lors de l\'inscription' });
    }
});

//Endpoint Connexion
router.post('/login', async (req, res) => {
    const { email, password } = req.body; // Récupérer les données du corps de la requête

    try {
        // Rechercher l'utilisateur en fonction de l'email
        const [rows] = await db.query('SELECT * FROM `user` WHERE `email` = ?', [email]);

        // Vérifier si l'utilisateur existe
        if (rows.length === 0) {
            return res.status(404).json({ error: 'Utilisateur non trouvé' });
        }

        const user = rows[0];

        // Comparer le mot de passe hashé
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return res.status(401).json({ error: 'Mot de passe incorrect' });
        }

        // Générer un token JWT pour l'authentification
        const payload = {
            user: {
                id: user.id,
                email: user.email,
                role:user.role,
                // Autres informations utilisateur que vous souhaitez inclure
            }
        };

        jwt.sign(payload, 'secret_jwt', { expiresIn: '1h' }, (err, token) => {
            if (err) throw err;
            res.json({ token });
        });

    } catch (err) {
        console.error('Erreur lors de la connexion', err);
        res.status(500).json({ error: 'Erreur lors de la connexion' });
    }
});

const verifyToken = (req, res, next) => {
    const token = req.header('x-auth-token');
    if (!token) return res.status(401).json({ msg: 'Pas de token, autorisation refusée' });

    try {
        const decoded = jwt.verify(token, 'votre_secret_jwt');
        req.user = decoded.user;
        next();
    } catch (err) {
        res.status(401).json({ msg: 'Token non valide' });
    }
};

const checkRole = (role) => (req, res, next) => {
    if (req.user.role !== role) {
        return res.status(403).json({ msg: 'Accès refusé' });
    }
    next();
};

router.get('/admin', verifyToken, checkRole('admin'), (req, res) => {
    res.send('Contenu réservé aux administrateurs');
});

router.get('/user', verifyToken, checkRole('user'), (req, res) => {
    res.send('Contenu réservé aux utilisateurs');
});


module.exports = router;
