import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/section_header.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  static const _faqs = [
    _Faq('How do I verify my business?',
        'Open Settings → Verification, upload your GST certificate and a government ID. Most reviews complete within 24 hours.'),
    _Faq('How are inquiries delivered?',
        'Inquiries are sent in real-time. You will see them in the Messages tab and receive push & email notifications based on your preferences.'),
    _Faq('Is there a charge for posting?',
        'Posting on the network is free. Premium placement and lead boosters are optional paid add-ons.'),
    _Faq('How do I delete my account?',
        'Contact support@waaro.in from your registered email and we will process the request within 7 working days.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.softYellowGradient,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Need help?',
                      style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.4)),
                  const SizedBox(height: 6),
                  Text('Our team responds within a few hours on business days.',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Row(children: [
                    _action(LucideIcons.mail, 'Email', 'support@waaro.in'),
                    const SizedBox(width: 10),
                    _action(LucideIcons.phone, 'Call', '+91 80000 80000'),
                  ]),
                ],
              ),
            ),
          ),
          const SectionHeader(title: 'Frequently asked'),
          ..._faqs.map((f) => Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderSoft),
                ),
                child: Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    title: Text(f.q, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
                    iconColor: AppColors.foreground,
                    collapsedIconColor: AppColors.textSecondary,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          f.a,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _action(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.foreground),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w700)),
                  Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w800, color: AppColors.foreground)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Faq {
  final String q;
  final String a;
  const _Faq(this.q, this.a);
}
