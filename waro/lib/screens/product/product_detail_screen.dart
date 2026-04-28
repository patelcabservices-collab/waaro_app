import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/primary_button.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Product'),
        actions: [
          IconButton(icon: const Icon(LucideIcons.bookmark), onPressed: () {}),
          IconButton(icon: const Icon(LucideIcons.share2), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Icon(LucideIcons.box, size: 56, color: AppColors.textMuted)),
          ),
          const SizedBox(height: 20),
          Text('Industrial Hydraulic Pump – Model HP-450',
              style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.4)),
          const SizedBox(height: 8),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.successSoft, borderRadius: BorderRadius.circular(999)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(LucideIcons.shieldCheck, size: 13, color: AppColors.success),
                const SizedBox(width: 4),
                Text('Verified seller',
                    style: GoogleFonts.plusJakartaSans(color: AppColors.success, fontWeight: FontWeight.w800, fontSize: 11.5)),
              ]),
            ),
            const SizedBox(width: 8),
            const Icon(LucideIcons.star, color: AppColors.primaryDark, size: 14),
            const SizedBox(width: 4),
            Text('4.8 (126 reviews)', style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 14),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('₹ 45,000',
                style: GoogleFonts.plusJakartaSans(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.5)),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text('/ unit', style: GoogleFonts.plusJakartaSans(fontSize: 13.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            ),
          ]),
          const SizedBox(height: 24),
          _section('Specifications', [
            _SpecRow('Brand', 'Bharat Engineering'),
            _SpecRow('Model', 'HP-450'),
            _SpecRow('Power', '5.5 HP'),
            _SpecRow('Max flow', '450 LPM'),
            _SpecRow('Min order', '5 units'),
            _SpecRow('Lead time', '7-10 days'),
          ]),
          const SizedBox(height: 20),
          _section('Description', [
            Text(
              'Heavy-duty hydraulic pump engineered for continuous industrial use. Cast iron body, precision-machined gears, and triple-seal protection ensure long service life under demanding loads.',
              style: GoogleFonts.plusJakartaSans(fontSize: 13.5, height: 1.55, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
            ),
          ]),
          const SizedBox(height: 20),
          _section('Seller', [
            Row(children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary.withOpacity(0.25),
                child: const Text('B', style: TextStyle(color: AppColors.foreground, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bharat Engineering', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
                    Text('Manufacturer · Pune · 12 yrs',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              OutlinedButton(onPressed: () {}, child: const Text('View profile')),
            ]),
          ]),
        ],
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.borderSoft)),
          ),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Message',
                  variant: PrimaryButtonVariant.outline,
                  icon: LucideIcons.messageCircle,
                  onPressed: () => Get.toNamed('/chat'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  label: 'Send Inquiry',
                  variant: PrimaryButtonVariant.dark,
                  icon: LucideIcons.send,
                  onPressed: () => Get.snackbar('Inquiry sent', 'Seller will respond shortly'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  const _SpecRow(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
          Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.foreground)),
        ],
      ),
    );
  }
}
