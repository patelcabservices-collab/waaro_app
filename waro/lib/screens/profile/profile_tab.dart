import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/primary_button.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Row(
              children: [
                Text('Profile', style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.5)),
                const Spacer(),
                _circleIcon(LucideIcons.bell, () => Get.toNamed('/notifications')),
                const SizedBox(width: 8),
                _circleIcon(LucideIcons.settings, () => Get.toNamed('/settings')),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.softYellowGradient,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderSoft),
              ),
              child: Obx(() {
                final user = auth.user.value;
                final name = user?.fullName ?? 'Welcome';
                final company = user?.companyName ?? 'Add your business';
                final role = (user?.role ?? 'Member').replaceAll('_', ' ');
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 33,
                        backgroundColor: AppColors.primary.withOpacity(0.4),
                        backgroundImage: user?.profilePic != null ? NetworkImage(user!.profilePic!) : null,
                        child: user?.profilePic == null
                            ? Text(
                                (name.isNotEmpty ? name[0] : 'W').toUpperCase(),
                                style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.foreground),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 17, color: AppColors.foreground, letterSpacing: -0.3)),
                          const SizedBox(height: 2),
                          Text(company, style: GoogleFonts.plusJakartaSans(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.foreground, borderRadius: BorderRadius.circular(999)),
                            child: Text(role, style: GoogleFonts.plusJakartaSans(color: AppColors.primary, fontSize: 10.5, fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: PrimaryButton(label: 'Edit profile', variant: PrimaryButtonVariant.dark, icon: LucideIcons.pencil, height: 46, onPressed: () => Get.toNamed('/edit-profile'))),
              const SizedBox(width: 10),
              Expanded(child: PrimaryButton(label: 'Verify', variant: PrimaryButtonVariant.outline, icon: LucideIcons.shieldCheck, height: 46, onPressed: () => Get.toNamed('/verification'))),
            ]),
            const SizedBox(height: 22),
            Row(children: [
              _stat('Posts', '24'),
              _stat('Products', '12'),
              _stat('Network', '4.8k'),
            ]),
            const SizedBox(height: 22),
            _menuCard([
              _MenuItem(LucideIcons.bookmark, 'Saved items', () => Get.toNamed('/saved')),
              _MenuItem(LucideIcons.layoutGrid, 'Categories', () => Get.toNamed('/categories')),
              _MenuItem(LucideIcons.search, 'Discover', () => Get.toNamed('/search')),
            ]),
            const SizedBox(height: 14),
            _menuCard([
              _MenuItem(LucideIcons.helpCircle, 'Help & Support', () => Get.toNamed('/support')),
              _MenuItem(LucideIcons.settings, 'Settings', () => Get.toNamed('/settings')),
              _MenuItem(LucideIcons.logOut, 'Log out', () => _confirmLogout(auth), danger: true),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(side: BorderSide(color: AppColors.borderSoft)),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: AppColors.foreground),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderSoft),
        ),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.foreground)),
            const SizedBox(height: 2),
            Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            ListTile(
              onTap: items[i].onTap,
              leading: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: items[i].danger ? AppColors.errorSoft : AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(items[i].icon, size: 18, color: items[i].danger ? AppColors.error : AppColors.foreground),
              ),
              title: Text(
                items[i].label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: items[i].danger ? AppColors.error : AppColors.foreground,
                ),
              ),
              trailing: Icon(LucideIcons.chevronRight, size: 16, color: items[i].danger ? AppColors.error : AppColors.textMuted),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            if (i != items.length - 1)
              const Divider(height: 1, color: AppColors.borderSoft, indent: 20, endIndent: 20),
          ],
        ],
      ),
    );
  }

  void _confirmLogout(AuthController auth) {
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

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  _MenuItem(this.icon, this.label, this.onTap, {this.danger = false});
}
