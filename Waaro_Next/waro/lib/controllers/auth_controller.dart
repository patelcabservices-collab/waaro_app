import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../core/constants/api_constants.dart';

class AuthController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userDetail = prefs.getString('userDetail');

    if (token != null && userDetail != null) {
      user.value = UserModel.fromJson(jsonDecode(userDetail));
      isLoggedIn.value = true;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _apiService.post(ApiConstants.signin, data: {
        'email': email,
        'password': password,
      });

      if (response.data['success'] == true) {
        final userData = response.data['data'];
        final token = userData['token'];
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userDetail', jsonEncode(userData));
        
        user.value = UserModel.fromJson(userData);
        isLoggedIn.value = true;
        
        return true;
      } else {
        Get.snackbar('Error', response.data['message'] ?? 'Login failed');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userDetail');
    user.value = null;
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
