import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String recipeId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Resep'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('recipes').doc(recipeId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Data tidak ditemukan'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Masakan
                Image.network(
                  data['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),

                // Detail Resep
                Text(
                  data['title'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Porsi: ${data['portion']}'),
                SizedBox(height: 8),
                Text('Durasi: ${data['duration']} menit'),
                SizedBox(height: 8),
                Text('Cerita Resep: ${data['story']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
