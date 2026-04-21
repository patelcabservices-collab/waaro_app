import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/theme/app_colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Glassy Profile Header
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Opacity(
                    opacity: 0.1,
                    child: Center(
                      child: Icon(LucideIcons.user, size: 200, color: Colors.white),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeaderButton(LucideIcons.chevronLeft, () => Get.back()),
                        _buildHeaderButton(LucideIcons.settings, () {}),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
                      ),
                      child: Obx(() {
                        final user = authController.user.value;
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.lightGrey,
                          backgroundImage: user?.profilePic != null ? NetworkImage(user!.profilePic!) : null,
                          child: user?.profilePic == null ? Text(user?.fullName?.substring(0, 1).toUpperCase() ?? 'U', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black)) : null,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 70),
            
            // Name & Role
            Obx(() {
              final user = authController.user.value;
              return Column(
                children: [
                  Text(
                    user?.fullName ?? 'USER NAME',
                    style: GoogleFonts.outfit(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      (user?.role ?? 'PARTNER').toUpperCase(),
                      style: GoogleFonts.outfit(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.companyName ?? 'Independent Enterprise',
                    style: GoogleFonts.outfit(color: AppColors.grey, fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              );
            }),
            
            const SizedBox(height: 32),
            
            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _buildStatItem('POSTS', '24'),
                  _buildStatItem('PRODUCTS', '12'),
                  _buildStatItem('NETWORK', '4.8k'),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Menu Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildPremiumMenu(LucideIcons.user, 'PERSONAL INFORMATION', 'Manage your details'),
                  _buildPremiumMenu(LucideIcons.briefcase, 'BUSINESS PROFILE', 'Company & catalog'),
                  _buildPremiumMenu(LucideIcons.shieldCheck, 'VERIFICATION', 'Status & documents'),
                  _buildPremiumMenu(LucideIcons.helpCircle, 'GET SUPPORT', 'Chat with us'),
                  
                  const SizedBox(height: 24),
                  
                  // Logout with premium style
                  InkWell(
                    onTap: () => _showLogoutDialog(context, authController),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.red.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.logOut, color: Colors.red, size: 22),
                          const SizedBox(width: 16),
                          Text(
                            'LOGOUT FROM ACCOUNT',
                            style: GoogleFonts.outfit(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5),
                          ),
                          const Spacer(),
                          const Icon(LucideIcons.chevronRight, color: Colors.red, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 22, color: AppColors.foreground),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 10, color: AppColors.grey, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumMenu(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 22, color: AppColors.foreground),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.2),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(color: AppColors.grey, fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, size: 18, color: AppColors.grey),
        ],
      ),
    );
  }
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.foreground, size: 20),
        title: Text(title, style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w600)),
        trailing: const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.grey),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(onPressed: () => controller.logout(), child: const Text('Logout', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

