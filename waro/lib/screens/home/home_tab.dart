import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/product_controller.dart';
import 'package:waro/widgets/product_card.dart';
import 'package:waro/widgets/inquiry_bottom_sheet.dart';
import 'package:waro/core/theme/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final ProductController controller = Get.put(ProductController());
  final List<String> roles = ["Manufacturer", "Distributor", "Wholesaler", "Trader", "Retailer", "Service_Provider"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Glassy Sticky Header
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.white.withOpacity(0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            title: Text(
              'Network',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: AppColors.foreground,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: false,
            actions: [
              _buildAppBarAction(LucideIcons.bell),
              const SizedBox(width: 8),
              _buildAppBarAction(LucideIcons.settings),
              const SizedBox(width: 16),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  children: [
                    // Premium Search Bar
                    TextField(
                      onChanged: (val) => controller.search(val),
                      decoration: InputDecoration(
                        hintText: 'Search partners, products...',
                        hintStyle: GoogleFonts.outfit(color: AppColors.grey, fontWeight: FontWeight.w500),
                        prefixIcon: const Icon(LucideIcons.search, size: 20, color: AppColors.primaryDark),
                        fillColor: AppColors.lightGrey.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Animated Role Filter
                    SizedBox(
                      height: 38,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: roles.length,
                        itemBuilder: (context, index) {
                          final role = roles[index];
                          return Obx(() {
                            final isSelected = controller.currentRole.value == role;
                            return GestureDetector(
                              onTap: () => controller.updateRole(role),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: isSelected 
                                    ? LinearGradient(colors: [AppColors.primary, AppColors.primaryDark])
                                    : null,
                                  color: isSelected ? null : AppColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
                                  border: Border.all(
                                    color: isSelected ? Colors.transparent : AppColors.border.withOpacity(0.5),
                                  ),
                                ),
                                child: Text(
                                  role.replaceAll('_', ' ').toUpperCase(),
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                    color: isSelected ? Colors.black : AppColors.grey,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Network Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: Obx(() {
              if (controller.isLoading.value && controller.products.isEmpty) {
                return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              }
              
              if (controller.products.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.users, size: 80, color: AppColors.grey),
                          const SizedBox(height: 20),
                          Text(
                            'NO PARTNERS FOUND',
                            style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductCard(
                      product: controller.products[index],
                      onInquiryClick: () {
                        Get.bottomSheet(
                          InquiryBottomSheet(product: controller.products[index]),
                          isScrollControlled: true,
                        );
                      },
                      onCallClick: () {
                        // Call logic
                      },
                    );
                  },
                  childCount: controller.products.length,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarAction(IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: AppColors.foreground),
        onPressed: () {},
      ),
    );
  }
}
