import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/models/post_model.dart';
import 'package:waro/core/theme/app_colors.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onSave;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = (post.image ?? '').isNotEmpty;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderSoft),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 8, 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primary.withOpacity(0.25),
                  backgroundImage: post.companyLogo != null ? NetworkImage(post.companyLogo!) : null,
                  child: post.companyLogo == null
                      ? Text(
                          (post.username?.substring(0, 1) ?? 'W').toUpperCase(),
                          style: GoogleFonts.plusJakartaSans(color: AppColors.foreground, fontWeight: FontWeight.w800),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.companyName ?? post.username ?? 'user',
                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.foreground),
                      ),
                      const SizedBox(height: 1),
                      Row(children: [
                        const Icon(LucideIcons.mapPin, size: 11, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(post.location ?? 'India',
                            style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      ]),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(LucideIcons.moreHorizontal, size: 18), onPressed: () {}),
              ],
            ),
          ),
          if (post.caption != null && post.caption!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                post.caption!,
                style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.foreground, fontWeight: FontWeight.w500, height: 1.5),
              ),
            ),
          if (hasImage)
            AspectRatio(
              aspectRatio: 1.4,
              child: CachedNetworkImage(
                imageUrl: post.image!,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.surfaceAlt),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.surfaceAlt,
                  child: const Center(child: Icon(LucideIcons.imageOff, color: AppColors.textMuted)),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            child: Row(
              children: [
                _action(post.liked ? LucideIcons.heart : LucideIcons.heart,
                    post.liked ? AppColors.error : AppColors.textSecondary, '${post.likes}', onLike),
                _action(LucideIcons.messageCircle, AppColors.textSecondary, 'Comment', onComment),
                _action(LucideIcons.send, AppColors.textSecondary, 'Share', onShare),
                const Spacer(),
                IconButton(
                  onPressed: onSave,
                  icon: Icon(LucideIcons.bookmark,
                      size: 19, color: post.isSaved ? AppColors.primaryDark : AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _action(IconData icon, Color color, String label, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(label,
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: color, fontSize: 12.5)),
          ],
        ),
      ),
    );
  }
}
