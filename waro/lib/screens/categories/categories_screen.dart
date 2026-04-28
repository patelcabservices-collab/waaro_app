import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static final List<_Cat> _cats = const [
    _Cat('Industrial Supplies', LucideIcons.factory, 1240),
    _Cat('Building Materials', LucideIcons.building2, 980),
    _Cat('Electronics', LucideIcons.cpu, 1560),
    _Cat('Textiles & Apparel', LucideIcons.shirt, 760),
    _Cat('Food & Beverage', LucideIcons.utensilsCrossed, 540),
    _Cat('Chemicals', LucideIcons.flaskConical, 410),
    _Cat('Agriculture', LucideIcons.sprout, 690),
    _Cat('Automotive', LucideIcons.car, 870),
    _Cat('Health & Medical', LucideIcons.heartPulse, 320),
    _Cat('Packaging', LucideIcons.package, 480),
    _Cat('Logistics', LucideIcons.truck, 230),
    _Cat('Services', LucideIcons.hand, 1020),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Categories'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.05,
        ),
        itemCount: _cats.length,
        itemBuilder: (_, i) {
          final c = _cats[i];
          return GestureDetector(
            onTap: () => Get.toNamed('/search', arguments: c.name),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderSoft),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(c.icon, color: AppColors.primaryDark, size: 22),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14, height: 1.2)),
                      const SizedBox(height: 4),
                      Text(
                        '${c.count} businesses',
                        style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Cat {
  final String name;
  final IconData icon;
  final int count;
  const _Cat(this.name, this.icon, this.count);
}
