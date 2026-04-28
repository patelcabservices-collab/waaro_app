import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:waro/services/api_service.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/constants/api_constants.dart';

class ChatController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final AuthController _authController = Get.find<AuthController>();
  
  IO.Socket? socket;
  var messages = [].obs;
  var isLoading = false.obs;

  void connectSocket() {
    final user = _authController.user.value;
    if (user == null) return;

    socket = IO.io(ApiConstants.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket!.onConnect((_) {
      print('Connected to socket');
      socket!.emit('setup', user.id);
    });

    socket!.on('message received', (newMessage) {
      messages.add(newMessage);
    });
  }

  Future<void> fetchConversation(String partnerId, {String? inquiryId, String? leadId}) async {
    try {
      isLoading.value = true;
      final user = _authController.user.value;
      if (user == null) return;

      final response = await _apiService.get(ApiConstants.conversation, queryParameters: {
        'userId1': user.id,
        'userId2': partnerId,
        if (inquiryId != null) 'inquiryId': inquiryId,
        if (leadId != null) 'leadId': leadId,
      });

      if (response.data['success'] == true) {
        messages.assignAll(response.data['messages'] ?? []);
      } else if (response.data is List) {
        messages.assignAll(response.data);
      }
    } catch (e) {
      print("Error fetching conversation: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String partnerId, String text, {String? inquiryId, String? leadId}) async {
    try {
      final user = _authController.user.value;
      if (user == null) return;

      final payload = {
        'senderId': user.id,
        'receiverId': partnerId,
        'text': text,
        if (inquiryId != null) 'inquiryId': inquiryId,
        if (leadId != null) 'leadId': leadId,
      };

      final response = await _apiService.post(ApiConstants.messages, data: payload);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final newMessage = response.data['data'] ?? response.data;
        messages.add(newMessage);
        socket?.emit('new message', newMessage);
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  @override
  void onClose() {
    socket?.disconnect();
    super.onClose();
  }
}
