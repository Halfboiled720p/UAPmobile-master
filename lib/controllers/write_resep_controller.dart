import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/recipe.dart'; // Pastikan model Recipe diimpor

class WriteResepController extends GetxController {
  // Controller untuk setiap TextField
  var titleController = TextEditingController();
  var portionController = TextEditingController();
  var durationController = TextEditingController();
  var storyController = TextEditingController();

  // Variabel untuk menyimpan path gambar yang dipilih
  var imagePath = ''.obs;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> uploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        imagePath.value = pickedImage.path; // Simpan path lokal gambar
        Get.snackbar('Success', 'Gambar berhasil dipilih!', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Info', 'Tidak ada gambar yang dipilih.', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memilih gambar: $e', snackPosition: SnackPosition.BOTTOM);
      print("Error picking image: $e");
    }
  }

  // Fungsi untuk mengunggah gambar ke Firebase Storage
  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('recipes/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  // Fungsi untuk menyimpan data resep ke Firestore
  Future<void> saveRecipeToFirestore({
    required String title,
    required String portion,
    required String duration,
    required String story,
    required String imageUrl,
  }) async {
    try {
      // Menyimpan data resep ke Firestore
      await FirebaseFirestore.instance.collection('recipes').add({
        'title': title,
        'portion': portion,
        'duration': duration,
        'story': story,
        'image': imageUrl,
        'created_at': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Resep berhasil disimpan!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan resep!', snackPosition: SnackPosition.BOTTOM);
      print("Error saving recipe: $e");
    }
  }

  // Fungsi untuk menyimpan resep dan mengunggah gambar
  Future<void> uploadRecipe() async {
    if (titleController.text.isNotEmpty &&
        portionController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        storyController.text.isNotEmpty &&
        imagePath.value.isNotEmpty) {
      try {
        // Mengunggah gambar ke Firebase Storage
        File imageFile = File(imagePath.value);
        String imageUrl = await uploadImageToStorage(imageFile);

        // Cek apakah gambar berhasil diunggah
        if (imageUrl.isNotEmpty) {
          // Menyimpan data resep ke Firestore
          await saveRecipeToFirestore(
            title: titleController.text,
            portion: portionController.text,
            duration: durationController.text,
            story: storyController.text,
            imageUrl: imageUrl,
          );

          // Reset form setelah berhasil upload
          titleController.clear();
          portionController.clear();
          durationController.clear();
          storyController.clear();
          imagePath.value = '';
        } else {
          // Menampilkan snackbar jika gambar gagal diunggah
          Get.snackbar('Error', 'Gagal mengunggah gambar!', snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        // Menangkap dan menampilkan error pada konsol dan snackbar
        print("Error in uploadRecipe: $e");
        Get.snackbar('Error', 'Terjadi kesalahan saat menyimpan resep!', snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // Jika form belum lengkap
      Get.snackbar('Error', 'Harap lengkapi semua data!', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
