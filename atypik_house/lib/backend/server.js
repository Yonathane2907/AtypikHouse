// server.js

const express = require('express');
const mysql = require('mysql');
const cors = require('cors'); // Importe le middleware CORS
const app = express();
const bodyParser = require('body-parser');
const port = 3000;
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
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
const PORT = process.env.PORT || 3000;
// Importer les routes
const userRoutes = require('./logement');
// Utiliser les routes
app.use('/api', userRoutes);
// Écoute du serveur Express sur le port spécifié
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});

