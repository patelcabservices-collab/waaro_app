import 'package:get/get.dart';
import 'package:waro/services/api_service.dart';
import 'package:waro/models/product_model.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/constants/api_constants.dart';

class ProductController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  var isLoading = false.obs;
  var products = <ProductModel>[].obs;
  var currentRole = "Manufacturer".obs;
  var searchQuery = "".obs;
  var page = 1.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    if (isLoading.value) return;
    
    try {
      if (!isLoadMore) {
        isLoading.value = true;
        page.value = 1;
        products.clear();
      }

      final response = await _apiService.get(ApiConstants.filterProducts, queryParameters: {
        'role': currentRole.value,
        'q': searchQuery.value,
        'page': page.value,
        'limit': 16,
      });

      if (response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        final newProducts = data.map((e) => ProductModel.fromJson(e)).toList();
        
        if (isLoadMore) {
          products.addAll(newProducts);
        } else {
          products.assignAll(newProducts);
        }
        
        hasMore.value = response.data['pagination']?['hasMore'] ?? false;
        if (hasMore.value) page.value++;
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateRole(String role) {
    currentRole.value = role;
    fetchProducts();
  }

  void search(String query) {
    searchQuery.value = query;
    fetchProducts();
  }
}
