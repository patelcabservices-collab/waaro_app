import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/controllers/product_controller.dart';
import 'package:waro/widgets/product_card.dart';
import 'package:waro/widgets/inquiry_bottom_sheet.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/section_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final ProductController controller = Get.put(ProductController());
  final AuthController auth = Get.find<AuthController>();
  final List<String> roles = const ['Manufacturer', 'Distributor', 'Wholesaler', 'Trader', 'Retailer', 'Service_Provider'];

  static const _categories = [
    _Cat('Industrial', LucideIcons.factory),
    _Cat('Building', LucideIcons.building2),
    _Cat('Electronics', LucideIcons.cpu),
    _Cat('Textiles', LucideIcons.shirt),
    _Cat('Food', LucideIcons.utensilsCrossed),
    _Cat('Chemicals', LucideIcons.flaskConical),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildHeroBanner()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildCategoryStrip()),
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Filter by role', action: 'See all', onAction: () => Get.toNamed('/categories')),
            ),
            SliverToBoxAdapter(child: _buildRoles()),
            const SliverToBoxAdapter(child: SectionHeader(title: 'Trending businesses')),
            _buildGrid(),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
      child: Row(
        children: [
          Obx(() {
            final user = auth.user.value;
            final letter = (user?.fullName?.substring(0, 1) ?? 'W').toUpperCase();
            return CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(0.3),
              backgroundImage: user?.profilePic != null ? NetworkImage(user!.profilePic!) : null,
              child: user?.profilePic == null
                  ? Text(letter, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: AppColors.foreground))
                  : null,
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() {
              final user = auth.user.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello,',
                      style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  Text(user?.fullName ?? 'Welcome back',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.3)),
                ],
              );
            }),
          ),
          IconButton(icon: const Icon(LucideIcons.bookmark), onPressed: () => Get.toNamed('/saved')),
          IconButton(icon: const Icon(LucideIcons.bell), onPressed: () => Get.toNamed('/notifications')),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        gradient: AppColors.softYellowGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.foreground, borderRadius: BorderRadius.circular(999)),
                  child: Text("India's No.1 B2B Network",
                      style: GoogleFonts.plusJakartaSans(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                ),
                const SizedBox(height: 12),
                Text('Find verified buyers and sellers',
                    style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.foreground, height: 1.2, letterSpacing: -0.4)),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed('/search'),
                  icon: const Icon(LucideIcons.search, size: 16),
                  label: const Text('Start exploring'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
            child: const Icon(LucideIcons.compass, size: 36, color: AppColors.foreground),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: GestureDetector(
        onTap: () => Get.toNamed('/search'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(LucideIcons.search, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 10),
              Expanded(
                child: Text('Search products, businesses…',
                    style: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontWeight: FontWeight.w600, fontSize: 13.5)),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: AppColors.foreground, borderRadius: BorderRadius.circular(999)),
                child: const Icon(LucideIcons.slidersHorizontal, size: 14, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryStrip() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: SizedBox(
        height: 92,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final c = _categories[i];
            return GestureDetector(
              onTap: () => Get.toNamed('/categories'),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.borderSoft),
                    ),
                    child: Icon(c.icon, color: AppColors.foreground, size: 22),
                  ),
                  const SizedBox(height: 8),
                  Text(c.label,
                      style: GoogleFonts.plusJakartaSans(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoles() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: roles.length,
        itemBuilder: (_, i) {
          final role = roles[i];
          return Obx(() {
            final selected = controller.currentRole.value == role;
            return GestureDetector(
              onTap: () => controller.updateRole(role),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? AppColors.foreground : AppColors.surface,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: selected ? AppColors.foreground : AppColors.border),
                ),
                child: Text(
                  role.replaceAll('_', ' '),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: selected ? AppColors.primary : AppColors.foreground,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildGrid() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      sliver: Obx(() {
        if (controller.isLoading.value && controller.products.isEmpty) {
          return const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(48), child: LoadingView()));
        }
        if (controller.products.isEmpty) {
          return const SliverToBoxAdapter(
            child: EmptyState(
              icon: LucideIcons.users,
              title: 'No partners found',
              subtitle: 'Try changing the role filter or check back soon.',
            ),
          );
        }
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.62,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final p = controller.products[index];
              return ProductCard(
                product: p,
                onInquiryClick: () => Get.bottomSheet(InquiryBottomSheet(product: p), isScrollControlled: true),
                onCallClick: () {},
              );
            },
            childCount: controller.products.length,
          ),
        );
      }),
    );
  }
}

class _Cat {
  final String label;
  final IconData icon;
  const _Cat(this.label, this.icon);
}
