import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/section_header.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static final _items = [
    _Notif(LucideIcons.messageSquare, 'New inquiry', 'Rajesh Kumar sent you an inquiry on Industrial Pump.', '2m'),
    _Notif(LucideIcons.userPlus, 'Connection request', 'Anita Sharma wants to connect with your business.', '1h'),
    _Notif(LucideIcons.heart, 'Post engagement', 'Your post received 24 new likes today.', '3h'),
    _Notif(LucideIcons.shieldCheck, 'Verification approved', 'Your business profile has been verified.', '1d'),
    _Notif(LucideIcons.tag, 'Price update', 'A buyer responded to your quoted price.', '2d'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () => Get.snackbar('All caught up', 'Marked all as read'),
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SectionHeader(title: 'Today'),
          ..._items.take(3).map((n) => _row(n)),
          const SectionHeader(title: 'Earlier'),
          ..._items.skip(3).map((n) => _row(n)),
        ],
      ),
    );
  }

  Widget _row(_Notif n) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.18), borderRadius: BorderRadius.circular(12)),
            child: Icon(n.icon, color: AppColors.primaryDark, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        n.title,
                        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.foreground),
                      ),
                    ),
                    Text(n.time, style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  n.body,
                  style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Notif {
  final IconData icon;
  final String title;
  final String body;
  final String time;
  const _Notif(this.icon, this.title, this.body, this.time);
}
