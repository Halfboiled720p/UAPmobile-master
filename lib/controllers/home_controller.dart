import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meal.dart'; // Import the Meal model
import 'package:http/http.dart' as http; // Import HTTP package
import 'dart:convert'; // For decoding JSON

class HomeController extends GetxController {
  var isLoading = true.obs; // Status untuk loading indicator
  var foodMeals = <Meal>[].obs; // Daftar makanan asli dari API
  var filteredMeals = <Meal>[].obs; // Daftar makanan yang telah difilter
  var mealDetail = Rx<Meal?>(null); // Detail makanan berdasarkan idMeal

  @override
  void onInit() {
    super.onInit();
    fetchMeals(); // Panggil fetchMeals() saat controller diinisialisasi
  }

  /// Fetch all meals data from API
  void fetchMeals() async {
    try {
      isLoading.value = true; // Tampilkan loading
      var mealsData = await fetchMealsFromApi(); // Ambil data dari API
      foodMeals.value = mealsData
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList(); // Konversi JSON ke objek Meal
      filteredMeals.value = foodMeals; // Tampilkan semua data awalnya
    } catch (e) {
      print('Error fetching meals: $e');
      Get.snackbar('Error', 'Gagal memuat data makanan.');
    } finally {
      isLoading.value = false; // Sembunyikan loading
    }
  }

  /// API call to fetch meals
  Future<List<Map<String, dynamic>>> fetchMealsFromApi() async {
    const url =
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef'; // URL API
    final response = await http.get(Uri.parse(url)); // Permintaan GET ke API

    if (response.statusCode == 200) {
      var data = json.decode(response.body); // Decode respons JSON
      return List<Map<String, dynamic>>.from(data['meals'] ?? []); // Ambil daftar makanan
    } else {
      throw Exception('Failed to load meals'); // Jika gagal
    }
  }

  /// Filter meals based on search query
  void searchMeals(String query) {
    if (query.isEmpty) {
      filteredMeals.value = foodMeals; // Tampilkan semua makanan jika query kosong
    } else {
      filteredMeals.value = foodMeals.where((meal) {
        return (meal.strMeal?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            (meal.strCategory?.toLowerCase().contains(query.toLowerCase()) ?? false);
      }).toList();
    }
  }

  /// Fetch meal details by id
  Future<void> fetchMealDetail(String idMeal) async {
    try {
      var mealData = await fetchMealDetailFromApi(idMeal);
      mealDetail.value = Meal.fromJson(mealData); // Tetapkan detail makanan
    } catch (e) {
      print('Error fetching meal details: $e');
      Get.snackbar('Error', 'Gagal memuat detail makanan.');
    }
  }

  /// API call to fetch meal details
  Future<Map<String, dynamic>> fetchMealDetailFromApi(String idMeal) async {
    final url =
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMeal'; // URL API untuk detail makanan
    final response = await http.get(Uri.parse(url)); // Permintaan GET

    if (response.statusCode == 200) {
      var data = json.decode(response.body); // Decode respons JSON
      return (data['meals']?.first ?? {}); // Ambil data makanan pertama
    } else {
      throw Exception('Failed to load meal details'); // Jika gagal
    }
  }
}
