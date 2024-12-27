import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'meal_detail_view.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFF8E1), // Background color of the page
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  controller.searchMeals(query);
                },
                decoration: InputDecoration(
                  filled: true, // Add background to TextField
                  fillColor: Color(0xFFFFF8E1), // Same color as the background
                  hintText: 'Cari Makanan...',
                  prefixIcon: Icon(Icons.search, color: Colors.black87),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black87, width: 2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return PageView.builder(
                  itemCount: controller.filteredMeals.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final meal = controller.filteredMeals[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        color: Colors.orange, // Orange card background
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: Image.network(
                                meal.strMealThumb,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.strMeal,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // White text for meal name
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    meal.strArea ?? 'Unknown Area',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70, // Light white text for area
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => MealDetailView(meal: meal)); // Updated navigation
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, // White button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Detail Resep',
                                style: TextStyle(
                                  color: Colors.orange, // Orange text on the button
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
