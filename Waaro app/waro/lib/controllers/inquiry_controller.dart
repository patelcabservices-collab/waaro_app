import 'package:get/get.dart';
import 'package:waro/services/api_service.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/constants/api_constants.dart';

class InquiryController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final AuthController _authController = Get.find<AuthController>();

  var isLoading = false.obs;
  var inquiries = [].obs;
  var leads = [].obs;
  var callAlerts = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInquiries();
    fetchLeads();
    fetchCallAlerts();
  }

  Future<void> fetchInquiries() async {
    try {
      isLoading.value = true;
      final user = _authController.user.value;
      if (user == null) return;

      final response = await _apiService.get(ApiConstants.inquiries, queryParameters: {
        'type': 'inquiry',
        'receiverId': user.id,
      });

      if (response.data['success'] == true) {
        inquiries.assignAll(response.data['inquiries'] ?? []);
      }
    } catch (e) {
      print("Error fetching inquiries: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeads() async {
    try {
      final user = _authController.user.value;
      if (user == null) return;

      final response = await _apiService.get(ApiConstants.leads, queryParameters: {
        'receiverId': user.id,
      });

      if (response.data != null) {
        leads.assignAll(response.data['leads'] ?? response.data ?? []);
      }
    } catch (e) {
      print("Error fetching leads: $e");
    }
  }

  Future<void> fetchCallAlerts() async {
    try {
      final user = _authController.user.value;
      if (user == null) return;

      final response = await _apiService.get(ApiConstants.inquiries, queryParameters: {
        'type': 'call',
        'receiverId': user.id,
      });

      if (response.data['success'] == true) {
        callAlerts.assignAll(response.data['inquiries'] ?? []);
      }
    } catch (e) {
      print("Error fetching call alerts: $e");
    }
  }
}
