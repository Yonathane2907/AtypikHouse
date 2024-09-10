import 'package:flutter/material.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Assurez-vous d'importer le bon fichier

class LegalNoticePage extends StatelessWidget {
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
                    'Mentions Légales',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.0),
                 Text(
                     'Conformément aux dispositions des articles 6-III et 19 de la Loi n° 2004-575 du 21 juin 2004 pour la Confiance dans l’Économie Numérique (LCEN), nous portons à la connaissance des utilisateurs et visiteurs du site https://dsp-dev4-gv-kt-yb.fr/ les informations suivantes :',
                   style: Theme.of(context).textTheme.bodyLarge,
                 ),
                  SizedBox(height: 16.0),

                  Text(
                    '1. Informations légales',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Raison sociale : Atypikhouse \n Forme juridique : Société à responsabilité limitée (SARL) \n Capital social : 10 000 euros \n Siège social : 123 Rue des Hirondelles, 60123 Pierrefonds, France \n Numéro SIREN : 165438764 \n Numéro SIRET : 16543876498765 \n Numéro de TVA intracommunautaire : FR12765457887 \n Code APE/NAF : 5520Z ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '2. Directeur de la publication',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Le directeur de la publication est [Yonathane BEN ADMON] \n Contact : [Yonathane@dcws.com]',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '3. Hébergeur du site',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'L\'hébergement du site www.atypikhouse.fr est assuré par : \n Nom de l\'hébergeur : [Hostinger] \n Siège social de l\'hébergeur : [ 61 Lordou Vironos Street, 6023 Larnaca, Chypre] \n Site web de l\'hébergeur : [https://www.hostinger.fr/]',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '4. Propriété intellectuelle',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Tous les contenus présents sur le site https://dsp-dev4-gv-kt-yb.fr/, incluant, de façon non limitative, les graphismes, images, textes, vidéos, animations, sons, logos, gifs et icônes ainsi que leur mise en forme sont la propriété exclusive de la société Atypikhouse, à l\'exception des marques, logos ou contenus appartenant à d\'autres sociétés partenaires ou auteurs. \n Toute reproduction, distribution, modification, adaptation, retransmission ou publication, même partielle, de ces différents éléments est strictement interdite sans l\'accord exprès par écrit d’Atypikhouse. \n Cette représentation ou reproduction, par quelque procédé que ce soit, constitue une contrefaçon sanctionnée par les articles L.335-2 et suivants du Code de la propriété intellectuelle..',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '5. Protection des données personnelles',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Conformément à la loi n° 78-17 du 6 janvier 1978 relative à l’informatique, aux fichiers et aux libertés, modifiée par le Règlement général sur la protection des données (RGPD) 2016/679, Atypikhouse assure la collecte et le traitement des données personnelles des utilisateurs du site dans le respect des droits des utilisateurs. \n Les informations recueillies par Atypikhouse via les formulaires présents sur le site sont utilisées exclusivement dans le cadre de la gestion de la relation avec le client (réservation, demande d’informations, etc.). \n Droit d’accès, de rectification, d’effacement et de portabilité des données : Conformément aux dispositions de la loi informatique et libertés et du RGPD, tout utilisateur dispose d’un droit d’accès, de rectification, d’effacement et de portabilité des données qui le concernent. Ces droits peuvent être exercés en adressant une demande à [Yonathane@dcws.com]. \n Droit d’opposition : Vous pouvez également, pour des motifs légitimes, vous opposer au traitement des données vous concernant.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '6. Cookies',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Le site https://dsp-dev4-gv-kt-yb.fr/ peut être amené à vous demander l’acceptation des cookies pour des besoins de statistiques et d\'affichage. \n Un cookie est une information déposée sur le disque dur de l\'internaute par le serveur du site visité. \n Il contient plusieurs données qui sont stockées sur votre appareil dans un simple fichier texte auquel un serveur accède pour lire et enregistrer des informations. \n Vous avez la possibilité de configurer votre navigateur pour refuser l’utilisation des cookies.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '7. Conditions d\'utilisation',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'L’utilisation du site https://dsp-dev4-gv-kt-yb.fr/ implique l’acceptation pleine et entière des conditions générales d’utilisation (CGU) accessibles à tout moment sur le site. \n Atypikhouse se réserve le droit de modifier, à tout moment et sans préavis, les présentes conditions légales. \n L\'utilisateur est donc invité à les consulter régulièrement.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '8. Responsabilité',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Atypikhouse met tout en œuvre pour assurer l\'exactitude des informations diffusées sur le site https://dsp-dev4-gv-kt-yb.fr/, mais ne saurait être tenu responsable des erreurs ou omissions. \n Le site peut contenir des liens vers d’autres sites web ou ressources disponibles sur Internet. Atypikhouse décline toute responsabilité quant au contenu de ces sites externes.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '9. Litiges',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'En cas de litige, le droit applicable sera celui en vigueur en France, et les juridictions compétentes seront celles relevant du ressort du siège social d’Atypikhouse.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '10. Contact',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    ' Pour toute question ou demande concernant les mentions légales, merci de nous contacter : \n Par e-mail : [Yonathane@dcws.com ] \n Par téléphone : [0158743692] \n Par courrier : Atypikhouse, 123 Rue des Hirondelles, 60123 Pierrefonds, France',
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
