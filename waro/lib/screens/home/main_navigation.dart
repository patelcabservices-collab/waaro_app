import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final List<Widget> _tabs = const [
    HomeTab(),
    PostsTab(),
    CreateTab(),
    InquiriesTab(),
    ProfileTab(),
  ];

  static const _items = [
    _NavItem(LucideIcons.compass, 'Network'),
    _NavItem(LucideIcons.rss, 'Feed'),
    _NavItem(LucideIcons.plus, 'Create'),
    _NavItem(LucideIcons.messageCircle, 'Messages'),
    _NavItem(LucideIcons.user, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          decoration: BoxDecoration(
            color: AppColors.foreground,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.foreground.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_items.length, (i) {
              final selected = i == _currentIndex;
              final item = _items[i];
              final isCreate = i == 2;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _currentIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    height: 48,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: selected ? 14 : 0),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : (isCreate ? Colors.white.withOpacity(0.08) : Colors.transparent),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 20,
                          color: selected ? AppColors.foreground : Colors.white,
                        ),
                        if (selected) ...[
                          const SizedBox(width: 8),
                          Text(
                            item.label,
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.foreground,
                              fontWeight: FontWeight.w800,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
