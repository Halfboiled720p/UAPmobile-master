import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meal.dart'; // Import the Meal model

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  MealDetailScreen({required this.meal});

  @override
  Widget build(BuildContext context) {
    // Add an observable variable to track loading state
    var isDataLoaded = false.obs;

    // Simulate a loading delay
    Future.delayed(Duration(seconds: 1), () {
      isDataLoaded.value = true; // Data loading is complete after 1 second
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.strMeal),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal image
            Image.network(
              meal.strMealThumb,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, size: 200),
            ),
            SizedBox(height: 20),
            // Meal name
            Text(
              meal.strMeal,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Category and Area, displayed after data is loaded
            Obx(() {
              if (!isDataLoaded.value) {
                return Container(); // Display nothing until data is loaded
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${meal.strCategory}'),
                  Text('Area: ${meal.strArea}'),
                ],
              );
            }),
            SizedBox(height: 20),
            // Instructions, displayed after data is loaded
            Obx(() {
              if (!isDataLoaded.value) {
                return Container(); // Display nothing until data is loaded
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    meal.strInstructions,
                    textAlign: TextAlign.justify,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}