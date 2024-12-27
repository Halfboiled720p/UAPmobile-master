import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icon to go back
          onPressed: () {
            Get.back(); // Navigate to the previous page
          },
        ),
        backgroundColor: Color(0xFFFFF8E1), // Change AppBar color
        elevation: 0, // Remove the shadow from the AppBar
      ),
      body: Container(
        color: Color(0xFFFFF8E1), // Background color
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 80),
                // Circle image at the top
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    width: 180,
                    height: 180,
                    child: Image.asset(
                      'assets/login_image.png', // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Email input field
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                // Password input field with show/hide feature
                Obx(() {
                  return TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(controller.isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  );
                }),
                SizedBox(height: 20),
                // Login button
                ElevatedButton(
                  onPressed: () {
                    // Directly go to the dashboard without waiting for login result
                    Get.toNamed('/dashboard_view');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50), // Button size
                    padding: EdgeInsets.symmetric(vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded button corners
                    ),
                    backgroundColor: Colors.orange, // Button background color
                  ),
                  child: Text(
                    'Masuk',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                // Separator or text "Atau daftar menggunakan"
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Atau daftar menggunakan",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 20),
                // Google login button
                OutlinedButton.icon(
                  onPressed: controller.loginWithGoogle,
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red), // Google icon
                  label: Text("Google", style: TextStyle(fontSize: 16, color: Colors.black)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // Button background color
                    side: BorderSide(color: Colors.red), // Red border
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Facebook login button
                OutlinedButton.icon(
                  onPressed: controller.loginWithFacebook,
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue), // Facebook icon
                  label: Text("Facebook", style: TextStyle(fontSize: 16, color: Colors.black)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // Button background color
                    side: BorderSide(color: Colors.blue), // Blue border
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun? ", style: TextStyle(color: Colors.black)),
                    GestureDetector(
                      onTap: controller.goToRegister, // Navigate to the register page
                      child: Text(
                        "Daftar sekarang!",
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
