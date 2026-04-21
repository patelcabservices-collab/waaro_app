import 'package:get/get.dart';
import 'package:waro/services/api_service.dart';
import 'package:waro/models/post_model.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/constants/api_constants.dart';

class PostController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final AuthController _authController = Get.find<AuthController>();
  
  var isLoading = false.obs;
  var posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      String userId = _authController.user.value?.id ?? "guest";
      
      final response = await _apiService.get("/$userId${ApiConstants.getPosts}");

      if (response.data is List) {
        final List data = response.data;
        posts.assignAll(data.map((e) => PostModel.fromJson(e)).toList());
      }
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> likePost(String postId) async {
    try {
      final postIndex = posts.indexWhere((p) => p.id == postId);
      if (postIndex == -1) return;
      
      final post = posts[postIndex];
      // Optimistic update
      post.liked = !post.liked;
      post.likes = post.liked ? post.likes + 1 : post.likes - 1;
      posts[postIndex] = post;
      posts.refresh();

      String userId = _authController.user.value?.id ?? '';
      await _apiService.post("/$postId${ApiConstants.likePost}", data: {'userId': userId});
    } catch (e) {
      print("Error liking post: $e");
    }
  }
}
