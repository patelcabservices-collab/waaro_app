import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/section_header.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  static const _items = [
    _Saved('Industrial Hydraulic Pump', 'Bharat Engineering · Pune', '₹ 45,000', LucideIcons.box),
    _Saved('SS 304 Sheet 1.2mm', 'Steel Mart · Mumbai', '₹ 240/kg', LucideIcons.layers),
    _Saved('LED Floodlight 200W', 'BrightCo · Delhi', '₹ 1,850', LucideIcons.lightbulb),
    _Saved('Cotton Yarn 30s', 'Textile Hub · Coimbatore', '₹ 320/kg', LucideIcons.shirt),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Saved'),
      ),
      body: _items.isEmpty
          ? const EmptyState(
              icon: LucideIcons.bookmark,
              title: 'Nothing saved yet',
              subtitle: 'Tap the bookmark icon on any product or post to save it for later.',
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              itemCount: _items.length,
              itemBuilder: (_, i) {
                final s = _items[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.borderSoft),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(14)),
                        child: Icon(s.icon, color: AppColors.foreground),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(s.seller, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 6),
                            Text(s.price, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: AppColors.primaryDark, fontSize: 13.5)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.bookmark, color: AppColors.primaryDark, size: 18),
                        onPressed: () => Get.snackbar('Removed', 'Item removed from saved'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _Saved {
  final String title;
  final String seller;
  final String price;
  final IconData icon;
  const _Saved(this.title, this.seller, this.price, this.icon);
}
