import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import 'home_view.dart';
import 'write_recipe_view.dart';
import 'favorites_view.dart';
import 'inspiration_view.dart';
import 'profile_view.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find();

    return Obx(
          () => Scaffold(
        appBar: controller.selectedIndex.value == 0 // Only show AppBar on HomeView
            ? AppBar(
          title: Text(
            'Masak Apa Hari ini Bro ?',
            style: TextStyle(color: Colors.orange), // Set AppBar text color to orange
          ),
          backgroundColor: Color(0xFFFFF8E1), // Change AppBar color
          leading: IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(controller.profileImage.value),
            ),
            onPressed: () {
              controller.changePage(4); // Navigate to Profile page
            },
          ),
        )
            : null, // AppBar is null for other views
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/dashboard_back.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              HomeView(),
              WriteRecipeView(),
              FavoritView(),
              InspirationView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xFFFFAF42), // Change BottomNavigationBar color
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Tulis Resep',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Resep Saya',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
