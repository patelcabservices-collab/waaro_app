import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/post_controller.dart';
import 'package:waro/widgets/post_card.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/section_header.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
              child: Row(
                children: [
                  Text('Feed', style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.5)),
                  const Spacer(),
                  IconButton(icon: const Icon(LucideIcons.search), onPressed: () => Get.toNamed('/search')),
                  IconButton(icon: const Icon(LucideIcons.bell), onPressed: () => Get.toNamed('/notifications')),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.posts.isEmpty) {
                  return const LoadingView();
                }
                if (controller.posts.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.rss,
                    title: 'No posts yet',
                    subtitle: 'Be the first to share an opportunity, requirement, or update.',
                    actionLabel: 'Create a post',
                    onAction: () {},
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primaryDark,
                  onRefresh: () => controller.fetchPosts(),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      final post = controller.posts[index];
                      return PostCard(
                        post: post,
                        onLike: () => controller.likePost(post.id),
                        onComment: () => Get.toNamed('/post'),
                        onShare: () {},
                        onSave: () {},
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
