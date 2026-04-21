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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Premium Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    backgroundImage: post.companyLogo != null ? NetworkImage(post.companyLogo!) : null,
                    child: post.companyLogo == null ? Text(post.username?.substring(0, 1).toUpperCase() ?? 'U', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)) : null,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.companyName ?? post.username ?? 'user',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: -0.2),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(LucideIcons.mapPin, size: 10, color: AppColors.primaryDark),
                          const SizedBox(width: 4),
                          Text(
                            '${post.location ?? "Location"}',
                            style: GoogleFonts.outfit(fontSize: 11, color: AppColors.grey, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Material(
                  color: AppColors.lightGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(LucideIcons.moreHorizontal, size: 20, color: AppColors.foreground),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Image with Scale Animation
          Hero(
            tag: 'post_${post.id}',
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: post.image ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: AppColors.lightGrey.withOpacity(0.3)),
                  ),
                  // Subtle overlay gradient
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.2)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Interactions Tray (Glassmorphism look)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _buildPostButton(
                            post.liked ? LucideIcons.heart : LucideIcons.heart,
                            post.liked ? Colors.red : AppColors.foreground,
                            onLike,
                            isFilled: post.liked,
                          ),
                          const SizedBox(width: 4),
                          _buildPostButton(LucideIcons.messageCircle, AppColors.foreground, onComment),
                          const SizedBox(width: 4),
                          _buildPostButton(LucideIcons.send, AppColors.foreground, onShare),
                        ],
                      ),
                    ),
                    _buildPostButton(
                      post.isSaved ? LucideIcons.bookmark : LucideIcons.bookmark,
                      post.isSaved ? AppColors.primaryDark : AppColors.foreground,
                      onSave,
                      isFilled: post.isSaved,
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                if (post.likes > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      '${post.likes} LIKES',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5, color: AppColors.foreground),
                    ),
                  ),
                  
                if (post.caption != null && post.caption!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 8),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.outfit(color: AppColors.foreground, fontSize: 15, height: 1.4),
                        children: [
                          TextSpan(
                            text: '${post.username}  ',
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          TextSpan(text: post.caption, style: const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostButton(IconData icon, Color color, VoidCallback? onTap, {bool isFilled = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: color,
            size: 24,
            fill: isFilled ? 1 : 0,
          ),
        ),
      ),
    );
  }
  }

