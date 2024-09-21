import 'package:flutter/material.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Assurez-vous d'importer le bon fichier

class ContratGeneralVente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarWidget(),
    drawer: DrawerWidget(),
    body: Column(
    children: [
    Expanded(
    child: SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Conditions Générales de Vente (CGV)',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    SizedBox(height: 16.0),
    Text(
    ' Il est préalablement précisé que les présentes conditions régissent exclusivement les ventes par la boutique Atypikhouse, propriété de la SARL Atypikhouse, Société à Responsabilité Limitée au capital de 10 000 €, RCS 6543876598 , dont le siège est situé au 123 Rue des Hirondelles, 60123 Pierrefonds, France .',
    style: Theme.of(context).textTheme.bodyLarge,
    ),
    SizedBox(height: 16.0),

    Text(
    '1. Objet',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    SizedBox(height: 8.0),
      Text(
        'Les présentes CGV ont pour objet de définir les conditions dans lesquelles Atypikhouse propose à la location des habitations insolites. Toute réservation implique l’acceptation sans réserve des présentes CGV par le Locataire.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '2. Descriptions des hébergements',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les hébergements proposés par Atypikhouse sont des habitations insolites, à savoir : \n Cabanes dans les arbres \n Yourtes \n Cabanes flottantes \n Tentes suspendues et autres habitations atypiques. \n Les caractéristiques des hébergements, telles que leur capacité d\'accueil, les équipements fournis, et les services proposés, sont indiquées dans les fiches descriptives présentes sur le site internet d’Atypikhouse.',
          style: Theme.of(context).textTheme.bodyLarge,
      ),
    SizedBox(height: 16.0),
    Text(
    '3. Conditions de réservation',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    SizedBox(height: 8.0),
    Text(
    '3.1 Modalités de réservation',
    style: Theme.of(context).textTheme.titleMedium,
    ),
    SizedBox(height: 8.0),
    Text(
    'Les réservations peuvent être effectuées en ligne via le site internet d’Atypikhouse ou par tout autre moyen de communication mis à disposition. La réservation n\'est validée qu\'après le paiement d’un acompte ou de la totalité de la location.',
    style: Theme.of(context).textTheme.bodyLarge,
    ),
    SizedBox(height: 8.0),
    Text(
    '3.2  Validation de la réservation',
    style: Theme.of(context).textTheme.titleMedium,
    ),
    SizedBox(height: 8.0),
    Text(
    'La réservation est confirmée après réception d\'une confirmation écrite par email de la part d’Atypikhouse, accompagnée du paiement d’un acompte correspondant à 30% du montant total de la location.',
        style: Theme.of(context).textTheme.bodyLarge,
    ),
    SizedBox(height: 8.0),
      Text(
        '3.3  Annulation par le Locataire',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les modalités d’annulation sont les suivantes : \n -Annulation plus de 30 jours avant la date d’arrivée : remboursement intégral. \n -Annulation entre 15 et 30 jours avant la date d’arrivée : remboursement de 50% du montant total de la location. \n -Annulation moins de 15 jours avant la date d’arrivée : aucun remboursement ne sera effectué.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '4. Tarifs et conditions de paiement',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        '4.1 Tarifs',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les tarifs des locations sont affichés en euros, toutes taxes comprises (TTC), et varient en fonction de la saison, de la durée du séjour, et des promotions éventuelles.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        '4.2 Modalités de paiement',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les moyens de paiement acceptés incluent : \n -Carte bancaire \n -Virement bancaire \n -Chèque (sur accord préalable) \n -Autres moyens spécifiés sur le site d’Atypikhouse. \n Un acompte de 30% est requis à la réservation, et le solde doit être réglé au plus tard 15 jours avant le début du séjour.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '5. Caution',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Le Propriétaire peut demander une caution, dont le montant est spécifié au moment de la réservation. Cette caution est destinée à couvrir d’éventuels dommages causés à l’hébergement. \n Elle est restituée dans un délai de 10 jours après l’état des lieux de sortie, déduction faite des réparations éventuelles.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '6. Arrivée et départ',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        '6.1 Heures d’arrivée',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les arrivées sont possibles à partir de 16h00, sauf mention contraire.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        '6.2 Heures de départ',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les départs doivent avoir lieu avant 11h00. Tout départ tardif sans accord préalable peut entraîner des frais supplémentaires.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '7. Utilisation de l’hébergement',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Le Locataire s\'engage à respecter l’hébergement et à l’utiliser de manière appropriée. Toute dégradation ou dommage causé à l’hébergement sera déduit de la caution. \n Le Locataire s’engage également à respecter les règles spécifiques indiquées par le Propriétaire, telles que celles relatives aux nuisances sonores ou à l’usage des installations.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '8. Responsabilité',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        '8.1 Responsabilité du Loueur',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      SizedBox(height: 8.0),
      Text(
        'Atypikhouse agit en tant qu’intermédiaire et ne pourra être tenu responsable en cas de litige entre le Propriétaire et le Locataire, ou en cas de non-conformité de l’hébergement par rapport à la description fournie.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        '8.2 Responsabilité du Propriétaire',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      SizedBox(height: 8.0),
      Text(
        'Le Propriétaire est responsable de la conformité de l’hébergement et de son état de propreté à l’arrivée du Locataire. Le Propriétaire s’engage à rembourser le Locataire en cas de manquement grave à ces obligations.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '9. Assurance ',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Le Propriétaire est tenu de souscrire une assurance couvrant les risques locatifs. Il est également recommandé au Locataire de souscrire une assurance « villégiature » pour se protéger en cas de dommages matériels ou corporels survenant pendant son séjour.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '10. Animaux ',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'La présence d’animaux doit être signalée lors de la réservation et est soumise à l’autorisation du Propriétaire. Des frais supplémentaires peuvent être appliqués pour la présence d’animaux.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '11. Force majeure',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Aucun des contractants ne pourra être tenu responsable en cas d’inexécution ou de retard dans l’exécution de ses obligations en raison d’un cas de force majeure (catastrophes naturelles, pandémie, conditions météorologiques extrêmes, etc.).',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '12.  Service Après-Vente',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'AtypikHouse s\'engage à fournir un service après-vente de qualité pour répondre aux besoins de ses clients. En cas de problème, de réclamation ou d\'assistance nécessaire concernant votre location, veuillez contacter notre équipe de support client à l\'adresse électronique ou au numéro de téléphone indiqué sur notre site Internet. Nous mettrons tout en œuvre pour vous aider dans les plus brefs délais.',
      style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '13. Réclamations',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'En cas de litige ou de réclamation concernant un hébergement, le Locataire est invité à contacter Atypikhouse dans les 48 heures suivant l’arrivée. Si aucune solution amiable n’est trouvée, le litige pourra être soumis aux juridictions compétentes selon la législation française.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        ' Conditions Générales d\'Utilisation (CGU) ',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '1. Objet',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les présentes conditions régissent l\'utilisation du site web d\'AtypikHouse.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '2. Acceptation des conditions',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'En utilisant le site web d\'AtypikHouse, l\'utilisateur reconnaît avoir lu, compris et accepté les présentes CGU.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '3. Accès au site',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'AtypikHouse se réserve le droit de modifier, suspendre ou interrompre l\'accès à tout ou partie du site à tout moment, pour n\'importe quelle raison, et sans préavis.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '4. Propriété intellectuelle',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Tout le contenu présent sur le site web d\'AtypikHouse, y compris, mais sans s\'y limiter, les textes, les graphiques, les logos, les images, est la propriété d\'AtypikHouse et est protégé par le droit d\'auteur.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '5. Responsabilités',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'AtypikHouse ne peut être tenu responsable des dommages de toute nature résultant de l\'utilisation de son site.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      SizedBox(height: 16.0),
      Text(
        '6. Protection des données personnelles',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(height: 8.0),
      Text(
        'Les données personnelles que vous nous confiez en créant un compte client et en reservant un séjour, ou en faisant une demande d\'accompagnement de projet de labélisation, permettent à Atypikhouse  de vous proposer des offres et services adaptés et personnalisés. \n -A quoi nous servent vos données ? \n -A vous proposer des séjours et activités qui correspondent à vos attentes. \n  -A contractualiser une réservation ou des activités. \n -A vous proposer des services personnalisés en adéquation avec vos besoins. \n -A réaliser des statistiques. \n - A vous proposer des informations et newsletters ciblees adaptees a vos attentes. \nVos données sont confidentielles et protégées. \n Atypikhouse s\'engage à assurer la sécurité et la confidentialité de vos données personnelles. Elles sont conservées sur des serveurs sécurisés afin de vous protéger en cas de cyberattaque. Atypikhouse s\'engage à ne pas vendre ou céder vos données a des tiers.\n Pour pouvoir envoyer des informations, des bons de réservation, des newsletters, etc, ainsi que pour réaliser ses enquêtes de marché. Dans l\'objectif d\'améliorer notre offre et l\'expérience client sur notre site, nous collectons des statistiques anonymes comme : Combien de visiteurs recevons-nous ? Par quels pays le site est-il visité ? Quelles pages et thématiques sont les plus ou moins visitées ? \n Vous gardez le contrôle de vos données. \n Vous pouvez accéder aux données personnelles que vous nous avez confiées par simple demande, les mettre à jour, les supprimer ou demander à ce qu\'elles vous soient restituées. Pour plus d\'information sur la législation européenne et les droits en rapport avec vos données personnelles vous pouvez consulter le document - RGPD Informations supplémentaires pour les personnes résidant dans l\'UE, l\'EEE et la Suisse \n Pour exercer ces droits, contactez-nous.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    SizedBox(height: 16.0),
    Text(
    '7. Modification des CGU',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    SizedBox(height: 8.0),
    Text(
    'AtypikHouse se réserve le droit de modifier les présentes CGU à tout moment. Les utilisateurs seront informés de ces modifications et seront réputés les avoir acceptées en continuant à utiliser le site après la date de mise en vigueur des modifications.',
    style: Theme.of(context).textTheme.bodyLarge,
    ),
    SizedBox(height: 16.0),
    Text(
    '8. Loi applicable et juridiction',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    SizedBox(height: 8.0),
    Text(
    'Les présentes CGU sont régies par le droit français. Tout litige relatif à leur interprétation et/ou à leur exécution relève des tribunaux français.',
    style: Theme.of(context).textTheme.bodyLarge,
    ),

    ],

    ),
    ),
    ),
    Footer(), // Ajout du Footer en bas de l'écran
    ],
    ),
    );
  }
}
