import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Untuk mendapatkan alamat dari koordinat
import 'package:permission_handler/permission_handler.dart'; // Untuk mengelola izin
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.orange), // Set text color to orange
            ),
            backgroundColor: Color(0xFFFFF8E1), // Set AppBar background color
            automaticallyImplyLeading: false, // Menghilangkan panah kiri atas (back button)
          ),
          backgroundColor: Color(0xFFFFF8E1), // Set page background color
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Bagian untuk foto profil
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.profileImage.value != null
                            ? FileImage(controller.profileImage.value!)
                            : null, // Jika tidak ada gambar, biarkan null
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Menggunakan pickImage untuk memilih gambar dari galeri
                              controller.pickImage(ImageSource.gallery);
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // Menggunakan pickImage untuk mengambil foto dari kamera
                              controller.pickImage(ImageSource.camera);
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.greenAccent,
                              child: Icon(Icons.camera, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Input untuk data profil
                  _buildTextField(
                    label: 'Full Name',
                    controller: controller.nameController,
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    label: 'Email',
                    controller: controller.emailController,
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    label: 'Phone Number',
                    controller: controller.phoneController,
                  ),
                  SizedBox(height: 20),
                  // Google Maps Widget
                  if (controller.latitude != null && controller.longitude != null)
                    SizedBox(
                      height: 300,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.latitude!, controller.longitude!),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('current_location'),
                            position: LatLng(controller.latitude!, controller.longitude!),
                            infoWindow: InfoWindow(title: 'Lokasi Anda'),
                          ),
                        },
                        onMapCreated: (GoogleMapController mapController) {
                          controller.setMapController(mapController);
                        },
                      ),
                    ),
                  SizedBox(height: 10),
                  // TextField untuk Latitude
                  _buildTextField(
                    label: 'Latitude',
                    controller: TextEditingController(
                      text: controller.latitude?.toString() ?? '',
                    ),
                    enabled: false, // Tidak dapat diedit
                  ),
                  SizedBox(height: 10),
                  // TextField untuk Longitude
                  _buildTextField(
                    label: 'Longitude',
                    controller: TextEditingController(
                      text: controller.longitude?.toString() ?? '',
                    ),
                    enabled: false, // Tidak dapat diedit
                  ),
                  SizedBox(height: 10),
                  // TextField untuk Alamat
                  _buildTextField(
                    label: 'Alamat',
                    controller: TextEditingController(
                      text: controller.address ?? 'Alamat tidak tersedia',
                    ),
                    enabled: false, // Tidak dapat diedit
                  ),
                  SizedBox(height: 20),
                  // Tombol Lokasi
                  ElevatedButton(
                    onPressed: () async {
                      if (await Permission.location.request().isGranted) {
                        await controller.getCurrentLocation(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Izin lokasi diperlukan untuk fitur ini.')),
                        );
                      }
                    },
                    child: Text('Get My Current Location'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Set button color to orange
                      foregroundColor: Colors.white, // Set button text color to white
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => controller.saveProfileData(context),
                    child: Text('Simpan Data'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Set button color to orange
                      foregroundColor: Colors.white, // Set button text color to white
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget untuk TextField
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true, // Tambahkan parameter untuk mengontrol apakah TextField dapat diedit
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      enabled: enabled, // Atur apakah TextField dapat diedit
    );
  }
}
