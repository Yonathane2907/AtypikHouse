import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:atypik_house/models/villa_model.dart';

class VillaSection extends StatelessWidget {
  const VillaSection({super.key});

  Future<List<Villa>> loadVillas(BuildContext context) async {
    final String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/villas.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Villa.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Villa>>(
      future: loadVillas(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No villas available');
        } else {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text('Nos types de logement',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return VillaCard(villa: snapshot.data![index]);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class VillaCard extends StatelessWidget {
  final Villa villa;

  const VillaCard({super.key, required this.villa});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              villa.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  villa.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  villa.description,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${villa.price}€ / nuit',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
