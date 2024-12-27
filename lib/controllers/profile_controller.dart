// ProfileController.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Untuk mendapatkan alamat dari koordinat

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker(); // Objek image picker untuk memilih gambar
  final box = GetStorage(); // Instansi GetStorage untuk menyimpan data

  var profileImage = Rx<File?>(null); // Variabel untuk menyimpan gambar profil
  var selectedImagePath = ''.obs; // Variabel untuk menyimpan path gambar
  var isImageLoading = false.obs; // Variabel untuk status loading

  // Controllers untuk input data profil
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Variabel untuk lokasi dan alamat
  double? latitude;
  double? longitude;
  String? address; // Variabel untuk menyimpan alamat
  Position? currentPosition;
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    mapController?.dispose();
  }

  // Fungsi untuk memilih gambar menggunakan kamera atau galeri
  Future<void> pickImage(ImageSource source) async {
    try {
      isImageLoading.value = true;
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path); // Memperbarui gambar profil
        selectedImagePath.value = pickedFile.path; // Memperbarui path gambar
        box.write('imagePath', pickedFile.path); // Menyimpan path gambar ke GetStorage
      } else {
        print('Tidak ada gambar yang dipilih.');
      }
    } catch (e) {
      print('Error memilih gambar: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  // Fungsi untuk menyimpan data profil (nama, email, telepon, dan gambar)
  void saveProfileData(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data profil berhasil disimpan.')),
    );
  }

  // Mengambil lokasi saat ini
  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      // Periksa apakah layanan lokasi diaktifkan
      if (!await Geolocator.isLocationServiceEnabled()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Layanan lokasi tidak diaktifkan.')),
        );
        return;
      }

      // Periksa izin lokasi
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Izin lokasi ditolak.')),
          );
          return;
        }
      }

      // Mendapatkan lokasi saat ini
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = currentPosition?.latitude;
      longitude = currentPosition?.longitude;

      // Mendapatkan alamat dari koordinat
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
      address = placemarks.first.street; // Contoh mengambil nama jalan

      update(); // Memperbarui UI dengan GetX
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error mendapatkan lokasi: $e')),
      );
    }
  }

  // Mengatur controller Google Maps
  void setMapController(GoogleMapController controller) {
    mapController = controller;
    update(); // Memperbarui UI dengan GetX
  }
}
