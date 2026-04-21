import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import '../home/home_tab.dart';
import '../posts/posts_tab.dart';
import '../create/create_tab.dart';
import '../inquiries/inquiries_tab.dart';
import '../profile/profile_tab.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const PostsTab(),
    const CreateTab(),
    const InquiriesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _tabs[_currentIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          border: Border(top: BorderSide(color: AppColors.border.withOpacity(0.3))),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.black,
              unselectedItemColor: AppColors.grey,
              selectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 0.5),
              unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.5),
              items: [
                _buildNavItem(LucideIcons.home, 'NETWORK', 0),
                _buildNavItem(LucideIcons.rss, 'POSTS', 1),
                _buildNavItem(LucideIcons.plusCircle, 'CREATE', 2),
                _buildNavItem(LucideIcons.messageSquare, 'CHAT', 3),
                _buildNavItem(LucideIcons.user, 'PROFILE', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 22),
      ),
      label: label,
    );
  }
}
