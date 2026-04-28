import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/app_text_field.dart';
import 'package:waro/widgets/common/primary_button.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _comment = TextEditingController();
  final List<_Comment> _comments = [
    const _Comment('Anita Sharma', 'Interested. Please share MOQ and lead time.', '2h'),
    const _Comment('Rajesh Kumar', 'We can supply 500 units. DM sent.', '5h'),
  ];
  bool _liked = false;
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Post'),
        actions: [
          IconButton(
            icon: Icon(_saved ? LucideIcons.bookmark : LucideIcons.bookmark,
                color: _saved ? AppColors.primaryDark : AppColors.foreground),
            onPressed: () => setState(() => _saved = !_saved),
          ),
          IconButton(icon: const Icon(LucideIcons.share2), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withOpacity(0.25),
                child: const Text('B', style: TextStyle(color: AppColors.foreground, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bharat Engineering', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text('Manufacturer · Pune · 3h ago',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              OutlinedButton(onPressed: () {}, child: const Text('Follow')),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Looking for distributors for our new range of industrial hydraulic pumps in West & South India. Competitive margins, marketing support, and exclusive territory rights available.',
            style: GoogleFonts.plusJakartaSans(fontSize: 14.5, height: 1.55, fontWeight: FontWeight.w500, color: AppColors.foreground),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(child: Icon(LucideIcons.image, size: 48, color: AppColors.textMuted)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _action(LucideIcons.heart, '128', _liked, () => setState(() => _liked = !_liked)),
              const SizedBox(width: 22),
              _action(LucideIcons.messageCircle, '${_comments.length}', false, () {}),
              const SizedBox(width: 22),
              _action(LucideIcons.share2, 'Share', false, () {}),
            ],
          ),
          const Divider(height: 36, color: AppColors.borderSoft),
          Text('Comments', style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ..._comments.map(_commentTile),
        ],
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.borderSoft)),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppTextField(controller: _comment, hint: 'Add a comment…', prefixIcon: LucideIcons.messageSquare),
              ),
              const SizedBox(width: 8),
              PrimaryButton(
                label: 'Send',
                width: 92,
                variant: PrimaryButtonVariant.dark,
                onPressed: () {
                  final t = _comment.text.trim();
                  if (t.isEmpty) return;
                  setState(() {
                    _comments.insert(0, _Comment('You', t, 'now'));
                    _comment.clear();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _action(IconData icon, String label, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: active ? AppColors.error : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(label,
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700, fontSize: 13, color: active ? AppColors.error : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _commentTile(_Comment c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(c.name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 13)),
              const Spacer(),
              Text(c.time, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          Text(c.body,
              style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.foreground, fontWeight: FontWeight.w500, height: 1.45)),
        ],
      ),
    );
  }
}

class _Comment {
  final String name;
  final String body;
  final String time;
  const _Comment(this.name, this.body, this.time);
}
