// server.js

const express = require('express');
const mysql = require('mysql');
const cors = require('cors'); // Importe le middleware CORS

const app = express();
const port = 3000;

// Configuration de la connexion à la base de données MySQL
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'atypik_house'
});

// Connexion à MySQL
connection.connect(err => {
    if (err) {
        console.error('Error connecting to MySQL:', err.stack);
        return;
    }
    console.log('Connected to MySQL as ID:', connection.threadId);
});

// Utilisation du middleware CORS
app.use(cors());

// Endpoint pour récupérer tous les utilisateurs
app.get('/api/users', (req, res) => {
    const sql = 'SELECT * FROM test';
    connection.query(sql, (err, results) => {
        if (err) {
            console.error('Error executing query:', err.stack);
            res.status(500).json({ error: 'Internal Server Error' });
            return;
        }
        res.json(results);
    });
});

// Écoute du serveur Express sur le port spécifié
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
