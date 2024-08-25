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
//Endpoint d'inscription
// Endpoint d'inscription
router.post('/signUp', async (req, res) => {
    console.log(req.body);
    const { nom, prenom, adresse, email, password, role } = req.body; // Récupérer les données du corps de la requête
    const hashedPassword = await bcrypt.hash(password, 10);

    try {
        // Vérifier si l'email est déjà utilisé
        const [existingUser] = await db.query('SELECT * FROM `user` WHERE `email` = ?', [email]);
        if (existingUser.length > 0) {
            return res.status(400).json({ error: 'L\'email est déjà utilisé' });
        }

        // Insérer l'utilisateur dans la table 'user'
        const [userResult] = await db.query(
            'INSERT INTO `user` (`nom`, `prenom`, `adresse`, `email`, `password`, `role`) VALUES (?, ?, ?, ?, ?, ?)',
            [nom, prenom, adresse, email, hashedPassword, role]
        );

        // Récupérer l'id de l'utilisateur inséré
        const userId = userResult.insertId;

        // Si le rôle est 'propriétaire', insérer dans la table 'propriétaire'
        if (role === 'Propriétaire') {
            await db.query(
                'INSERT INTO `proprietaire` (`user_id`) VALUES (?)',
                [userId]
            );
        }

        // Générer un token JWT pour l'utilisateur nouvellement inscrit
        const payload = {
            user: {
                id: userId,
                email: email,
                role: role
            }
        };

        jwt.sign(payload, 'secret_jwt', { expiresIn: '1h' }, (err, token) => {
            if (err) throw err;
            res.json({ token, role });
        });

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
            res.json({ token, role: user.role });
        });

    } catch (err) {
        console.error('Erreur lors de la connexion', err);
        res.status(500).json({ error: 'Erreur lors de la connexion' });
    }
});

// Middleware pour vérifier le token
const verifyToken = (req, res, next) => {
    const authHeader = req.header('Authorization');
    const token = authHeader && authHeader.startsWith('Bearer ') ? authHeader.substring(7) : null;

    if (!token) {
        return res.status(401).json({ msg: 'Pas de token, autorisation refusée' });
    }

    try {
        const decoded = jwt.verify(token, 'secret_jwt');
        req.user_role = decoded.user.role; // Extraction du rôle depuis la clé user.role
        next();
    } catch (err) {
        res.status(401).json({ msg: 'Token non valide' });
    }
};

// Middleware pour vérifier le rôle
const checkRole = (role) => (req, res, next) => {
    const userRole = req.user_role;

    if (userRole && userRole === role) {
        return next();
    }

    return res.status(403).json({ msg: 'Accès refusé' });
};

// Route protégée par le rôle
router.get('/admin', verifyToken, checkRole('admin'), (req, res) => {
    res.send("admin");
});

module.exports = router;

router.get('/user', verifyToken, checkRole('user'), (req, res) => {
    res.send('Contenu réservé aux utilisateurs');
});


module.exports = router;
