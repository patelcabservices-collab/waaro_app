import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waro/core/theme/app_theme.dart';
import 'package:waro/services/api_service.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/screens/splash/splash_screen.dart';
import 'package:waro/screens/login/login_screen.dart';
import 'package:waro/screens/home/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Services
  Get.put(ApiService());
  
  // Initialize Controllers
  Get.put(AuthController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Waaro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Match web default
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const MainNavigation()),
      ],
    );
  }
}
