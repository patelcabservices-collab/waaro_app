import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waro/controllers/post_controller.dart';
import 'package:waro/widgets/post_card.dart';
import 'package:waro/core/theme/app_colors.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Posts',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: AppColors.foreground,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.posts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.posts.isEmpty) {
          return Center(
            child: Text('No posts yet', style: GoogleFonts.outfit(fontSize: 16)),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchPosts(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return PostCard(
                post: post,
                onLike: () => controller.likePost(post.id),
                onComment: () {},
                onShare: () {},
                onSave: () {},
              );
            },
          ),
        );
      }),
    );
  }
}
