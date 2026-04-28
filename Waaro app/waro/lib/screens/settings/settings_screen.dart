import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/section_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _push = true;
  bool _email = true;
  bool _calls = false;

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SectionHeader(title: 'Account'),
          _tile(LucideIcons.user, 'Personal information', 'Name, email, mobile', () => Get.toNamed('/edit-profile')),
          _tile(LucideIcons.briefcase, 'Business profile', 'Company, products, catalog', () => Get.toNamed('/edit-profile')),
          _tile(LucideIcons.shieldCheck, 'Verification', 'Status & documents', () => Get.toNamed('/verification')),

          const SectionHeader(title: 'Preferences'),
          _switchTile(LucideIcons.bell, 'Push notifications', _push, (v) => setState(() => _push = v)),
          _switchTile(LucideIcons.mail, 'Email updates', _email, (v) => setState(() => _email = v)),
          _switchTile(LucideIcons.phoneCall, 'Allow direct calls', _calls, (v) => setState(() => _calls = v)),

          const SectionHeader(title: 'Support'),
          _tile(LucideIcons.helpCircle, 'Help center', 'Get answers to common questions', () => Get.toNamed('/support')),
          _tile(LucideIcons.shield, 'Privacy policy', 'How we handle your data', () => Get.toNamed('/support')),
          _tile(LucideIcons.fileText, 'Terms of service', null, () => Get.toNamed('/support')),

          const SectionHeader(title: 'About'),
          _tile(LucideIcons.info, 'About waaro', 'Version 1.0.0', () {}),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Material(
              color: AppColors.error.withOpacity(0.07),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () => _confirmLogout(context, auth),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.logOut, color: AppColors.error, size: 18),
                      const SizedBox(width: 12),
                      Text(
                        'Log out',
                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: AppColors.error, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, String? subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 18, color: AppColors.foreground),
        ),
        title: Text(title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 14)),
        subtitle: subtitle != null
            ? Text(subtitle, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500))
            : null,
        trailing: const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }

  Widget _switchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: SwitchListTile.adaptive(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryDark,
        secondary: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 18, color: AppColors.foreground),
        ),
        title: Text(title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 14)),
      ),
    );
  }

  void _confirmLogout(BuildContext context, AuthController auth) {
    Get.dialog(
      AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You can sign back in anytime.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              auth.logout();
            },
            child: const Text('Log out', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
