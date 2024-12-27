import 'package:apkmasak/views/favorites_view.dart';
import 'package:apkmasak/views/home_view.dart';
import 'package:apkmasak/views/inspiration_view.dart';
import 'package:apkmasak/views/profile_view.dart';
import 'package:apkmasak/views/write_recipe_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DashboardController extends GetxController {
  // Index awal untuk BottomNavigationBar
  var selectedIndex = 0.obs;

  // URL gambar profil
  var profileImage = 'assets/profile_image.png'.obs;

  // List halaman
  final pages = [
    HomeView(),
    WriteRecipeView(),
    FavoritView(),
    InspirationView(),
    ProfileView(),
  ];

  // Fungsi untuk mengubah index halaman
  void changePage(int index) {
    selectedIndex.value = index;
  }
}
