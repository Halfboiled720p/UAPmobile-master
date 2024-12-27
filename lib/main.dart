import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/inspiration_controller.dart';
import 'pages/welcome_page.dart';
import 'views/login_view.dart';
import 'bindings/login_binding.dart';
import 'views/register_view.dart';
import 'bindings/register_binding.dart';
import 'views/dashboard_view.dart';
import 'views/profile_view.dart';
import 'bindings/profile_binding.dart'; // Import ProfileBinding
import 'views/write_recipe_view.dart';
import 'views/favorites_view.dart';
import 'views/inspiration_view.dart';
import 'bindings/dashboard_binding.dart';
import 'bindings/inspiration_binding.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_messaging/firebase_messaging.dart'; // Import Firebase Messaging

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Menjamin bahwa binding sudah siap
  await Firebase.initializeApp();  // Inisialisasi Firebase
  await GetStorage.init(); // Inisialisasi GetStorage

  // Inisialisasi Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Meminta izin untuk menerima notifikasi (untuk iOS)
  await messaging.requestPermission();

  // Mendapatkan token Firebase Messaging
  String? token = await messaging.getToken();
  print("Firebase Messaging Token: $token"); // Menampilkan token

  // Mendengarkan pesan yang diterima ketika aplikasi di foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      // Tampilkan pesan atau lakukan tindakan lainnya
      print("Received message: ${message.notification?.title}");
    }
  });

  // Menangani pesan ketika aplikasi berada di background atau terminated
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(MyApp());
}

// Menangani pesan ketika aplikasi berada di background
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Logika untuk memeriksa apakah pengguna sudah login atau belum
    var isAuthenticated = GetStorage().read('isAuthenticated') ?? false;
    if (!isAuthenticated) {
      return RouteSettings(name: '/login'); // Redirect ke halaman login jika belum login
    }
    return null;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/welcome', // Set initial route
      getPages: [
        // Daftar routing
        GetPage(
          name: '/welcome',
          page: () => WelcomePage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginView(),
          binding: LoginBinding(), // Binding untuk login
        ),
        GetPage(
          name: '/register',
          page: () => RegisterView(),
          binding: RegisterBinding(), // Binding untuk register
        ),
        GetPage(
          name: '/dashboard_view',
          page: () => DashboardView(),
          binding: DashboardBinding(), // Binding untuk dashboard
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileView(),
          binding: ProfileBinding(), // Binding untuk profile
        ),
        GetPage(
          name: '/write_recipe',
          page: () => WriteRecipeView(),
        ),
        GetPage(
          name: '/favorites',
          page: () => FavoritView(),
        ),
        GetPage(
          name: '/inspiration',
          page: () => InspirationView(),
          binding: InspirationBinding(), // Gunakan binding untuk inspiration
        ),
      ],
    );
  }
}
