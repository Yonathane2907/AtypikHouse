import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Atypik House', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        IconButton(icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white), onPressed: () {}),
                        IconButton(icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white), onPressed: () {}),
                        IconButton(icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.white), onPressed: () {}),
                        IconButton(icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white), onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Liens utiles', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    TextButton(child: Text('CGV', style: TextStyle(color: Colors.white)), onPressed: () {}),
                    TextButton(child: Text('Mentions légales', style: TextStyle(color: Colors.white)), onPressed: () {}),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Email: contact@atypikhouse.com', style: TextStyle(color: Colors.white)),
                    Text('Téléphone: +33 1 23 45 67 89', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}