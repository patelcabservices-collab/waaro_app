import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/primary_button.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Business Verification'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.successSoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.success.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                  child: const Icon(LucideIcons.shieldCheck, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Get the verified badge',
                          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.foreground)),
                      const SizedBox(height: 4),
                      Text('Verified businesses get 3x more inquiries and rank higher in search.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500, height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Documents', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 12),
          _docTile(LucideIcons.fileBadge, 'GST Certificate', 'PDF or image · max 5MB', 'pending'),
          _docTile(LucideIcons.contact, 'PAN Card', 'PDF or image · max 5MB', 'verified'),
          _docTile(LucideIcons.fileSignature, 'Business Registration', 'Optional', 'missing'),
          _docTile(LucideIcons.mapPin, 'Address Proof', 'Utility bill or lease', 'missing'),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Submit for review',
            variant: PrimaryButtonVariant.dark,
            icon: LucideIcons.send,
            onPressed: () => Get.snackbar('Submitted', 'We will review within 24 hours.'),
          ),
        ],
      ),
    );
  }

  Widget _docTile(IconData icon, String name, String hint, String status) {
    Color color;
    String label;
    IconData badgeIcon;
    switch (status) {
      case 'verified':
        color = AppColors.success;
        label = 'Verified';
        badgeIcon = LucideIcons.checkCircle2;
        break;
      case 'pending':
        color = AppColors.warning;
        label = 'Under review';
        badgeIcon = LucideIcons.clock;
        break;
      default:
        color = AppColors.textMuted;
        label = 'Upload';
        badgeIcon = LucideIcons.upload;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppColors.foreground, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 13.5)),
                Text(hint, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(999)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(badgeIcon, size: 12, color: color),
              const SizedBox(width: 4),
              Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w800, color: color)),
            ]),
          ),
        ],
      ),
    );
  }
}
