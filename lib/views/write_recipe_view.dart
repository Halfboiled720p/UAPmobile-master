import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/write_resep_controller.dart';
import 'recipe_detail_view.dart'; // Pastikan import halaman detail resep

class WriteRecipeView extends StatelessWidget {
  final WriteResepController controller = Get.put(WriteResepController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tulis Resep', textAlign: TextAlign.left), // Text position to the left
        backgroundColor: Color(0xFFFFF8E1), // Set app bar background color
        automaticallyImplyLeading: false, // Remove back button
      ),
      backgroundColor: Color(0xFFFFF8E1), // Set scaffold background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Resep',
                  labelStyle: TextStyle(color: Colors.black), // Orange label color
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1), // Orange background for text field
                ),
              ),
              TextField(
                controller: controller.portionController,
                decoration: InputDecoration(
                  labelText: 'Porsi',
                  labelStyle: TextStyle(color: Colors.black), // Orange label color
                  filled: true,
                  fillColor: Colors.orange.withOpacity(0.1), // Orange background for text field
                ),
              ),
              TextField(
                controller: controller.durationController,
                decoration: InputDecoration(
                  labelText: 'Durasi',
                  labelStyle: TextStyle(color: Colors.black), // Orange label color
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1), // Orange background for text field
                ),
              ),
              TextField(
                controller: controller.storyController,
                decoration: InputDecoration(
                  labelText: 'Cerita Asal Resep',
                  labelStyle: TextStyle(color: Colors.black), // Orange label color
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1), // Orange background for text field
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Obx(() {
                return controller.imagePath.value.isEmpty
                    ? Text('Belum ada gambar yang dipilih')
                    : Image.file(File(controller.imagePath.value));
              }),
              ElevatedButton(
                onPressed: () async {
                  await controller.uploadImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Set button color to orange
                ),
                child: Text(
                  'Unggah Gambar',
                  style: TextStyle(color: Colors.white), // White text in button
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Mengunggah resep
                  await controller.uploadRecipe();

                  // Jika resep berhasil disimpan, arahkan ke halaman detail resep
                  // Anda bisa mengirimkan ID atau data resep lain jika diperlukan
                  Get.to(RecipeDetailView()); // Navigasi ke RecipeDetailView
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Set button color to orange
                ),
                child: Text(
                  'Unggah Resep',
                  style: TextStyle(color: Colors.white), // White text in button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
