import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waro/core/theme/app_theme.dart';
import 'package:waro/services/api_service.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/screens/splash/splash_screen.dart';
import 'package:waro/screens/login/login_screen.dart';
import 'package:waro/screens/signup/signup_screen.dart';
import 'package:waro/screens/home/main_navigation.dart';
import 'package:waro/screens/notifications/notifications_screen.dart';
import 'package:waro/screens/settings/settings_screen.dart';
import 'package:waro/screens/saved/saved_screen.dart';
import 'package:waro/screens/categories/categories_screen.dart';
import 'package:waro/screens/search/search_screen.dart';
import 'package:waro/screens/post/post_detail_screen.dart';
import 'package:waro/screens/product/product_detail_screen.dart';
import 'package:waro/screens/profile/edit_profile_screen.dart';
import 'package:waro/screens/support/support_screen.dart';
import 'package:waro/screens/verification/verification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ApiService());
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
      themeMode: ThemeMode.light,
      initialRoute: '/',
      defaultTransition: Transition.cupertino,
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/home', page: () => const MainNavigation()),
        GetPage(name: '/notifications', page: () => const NotificationsScreen()),
        GetPage(name: '/settings', page: () => const SettingsScreen()),
        GetPage(name: '/saved', page: () => const SavedScreen()),
        GetPage(name: '/categories', page: () => const CategoriesScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/post', page: () => const PostDetailScreen()),
        GetPage(name: '/product', page: () => const ProductDetailScreen()),
        GetPage(name: '/edit-profile', page: () => const EditProfileScreen()),
        GetPage(name: '/support', page: () => const SupportScreen()),
        GetPage(name: '/verification', page: () => const VerificationScreen()),
      ],
    );
  }
}
