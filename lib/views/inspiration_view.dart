import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inspiration_controller.dart';
import '../views/meal_detail_view.dart';

class InspirationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InspirationController controller = Get.put(InspirationController());
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspiration',
          style: TextStyle(color: Colors.orange), // Set text color to orange
        ),
        backgroundColor: Color(0xFFFFF8E1), // Set AppBar background color
        automaticallyImplyLeading: false, // Menghilangkan panah kiri atas (back button)
        toolbarHeight: 60, // Optional: Adjust the height of the AppBar if needed
      ),
      backgroundColor: Color(0xFFFFF8E1), // Set page background color
      body: Obx(() {
        // If no internet connection, show the "No Internet Connection" message and logo
        if (!controller.isConnected.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.signal_wifi_off,
                  size: 100,
                  color: Colors.red,
                ),
                SizedBox(height: 16),
                Text(
                  'No Internet Connection',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ],
            ),
          );
        }

        // If there is internet connection, show the search bar and meal list
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search meals...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey), // Set search icon color to white
                  filled: true,
                  fillColor: Colors.white, // Set background color to orange
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(color: Colors.grey), // Set text color to white
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.searchMeals(value);
                  }
                },
              ),
            ),
            if (controller.meals.isEmpty)
              Center(
                child: Text(
                  'No meals available.',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            if (controller.meals.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: controller.meals.length,
                  itemBuilder: (context, index) {
                    final meal = controller.meals[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: Colors.orange, // Set card background color to orange
                      child: ListTile(
                        leading: Image.network(
                          meal.strMealThumb,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.error),
                        ),
                        title: Text(
                          meal.strMeal,
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                        subtitle: Text(
                          meal.strCategory,
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                        onTap: () => Get.to(() => MealDetailView(meal: meal)),
                        trailing: IconButton(
                          icon: Icon(Icons.save, color: Colors.white), // Set icon color to white
                          onPressed: () {
                            // Simpan meal ke penyimpanan lokal
                            controller.storage.write(meal.idMeal, meal.toJson());
                            Get.snackbar(
                              'Saved',
                              '${meal.strMeal} has been saved locally.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
