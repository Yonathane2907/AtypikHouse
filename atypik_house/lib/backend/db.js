const mysql = require('mysql2');
const dotenv = require('dotenv');
// Charger les variables d'environnement
dotenv.config();
// Créer un pool de connexions MySQL
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});
module.exports = pool.promise(); // Utiliser le pool avec des Promises