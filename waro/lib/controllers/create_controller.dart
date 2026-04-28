import 'dart:io';
import 'package:get/get.dart';
import 'package:waro/services/api_service.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/constants/api_constants.dart';

class CreateController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final AuthController _authController = Get.find<AuthController>();

  var isLoading = false.obs;

  Future<bool> createProduct({
    required String productName,
    required String description,
    required double price,
    required String priceUnit,
    required String category,
    required String city,
    required String state,
    File? imageFile,
  }) async {
    try {
      isLoading.value = true;
      String? imageUrl;
      
      if (imageFile != null) {
        imageUrl = await _apiService.uploadFile(imageFile);
      }

      final user = _authController.user.value;
      if (user == null) return false;

      final response = await _apiService.post(ApiConstants.createProduct, data: {
        'role': user.role,
        'userId': user.id,
        'productName': productName,
        'description': description,
        'price': price,
        'priceUnit': priceUnit,
        'category': [category],
        'city': city,
        'state': state,
        'image': imageUrl,
        'createdBy': user.id,
      });

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Error creating product: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createPost({
    required String description,
    required String keywords,
    required File imageFile,
  }) async {
    try {
      isLoading.value = true;
      
      String? imageUrl = await _apiService.uploadFile(imageFile);
      if (imageUrl == null) return false;

      final user = _authController.user.value;
      if (user == null) return false;

      final response = await _apiService.post(ApiConstants.createPost, data: {
        'description': description,
        'keywords': keywords,
        'userId': user.id,
        'image': imageUrl,
      });

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Error creating post: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
