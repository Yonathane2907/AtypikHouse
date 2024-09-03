const express = require('express');
const router = express.Router();
const nodemailer = require('nodemailer');

// Utilisation de variables d'environnement pour le mot de passe
const SMTP_PASSWORD = process.env.SMTP_PASSWORD;

router.post('/send-email', (req, res) => {
    const { name, email, message } = req.body;

    // Configurer le transporteur SMTP
    const transporter = nodemailer.createTransport({
        host: 'smtp.hostinger.com',
        port: 465,
        secure: true, // Utiliser SSL
        auth: {
            user: 'admin@dsp-dev4-gv-kt-yb.fr', // Votre adresse email
            pass: SMTP_PASSWORD, // Mot de passe récupéré depuis les variables d'environnement
        },
    });

    // Configurer les options du mail
    const mailOptions = {
        from: '"Contact Form" <admin@dsp-dev4-gv-kt-yb.fr>', // Adresse d'expéditeur fixe
        replyTo: email, // L'adresse email de l'utilisateur pour que les réponses lui parviennent
        to: 'admin@dsp-dev4-gv-kt-yb.fr', // Adresse de réception
        subject: `Nouveau message de ${name}`, // Sujet du mail
        text: `Nom: ${name}\nEmail: ${email}\n\nMessage:\n${message}`, // Corps du mail
    };

    // Envoyer l'email
    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return res.status(500).send({ error: 'Échec de l\'envoi du message', details: error.toString() });
        }
        res.status(200).send('Message envoyé avec succès');
    });
});

module.exports = router;
