import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/models/product_model.dart';
import 'package:waro/core/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onInquiryClick;
  final VoidCallback? onCallClick;

  const ProductCard({
    super.key,
    required this.product,
    this.onInquiryClick,
    this.onCallClick,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // Detail page navigation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Hero
              Stack(
                children: [
                  Hero(
                    tag: 'product_${product.id}',
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: product.image ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.lightGrey, AppColors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.lightGrey,
                          child: const Icon(LucideIcons.image, color: AppColors.grey),
                        ),
                      ),
                    ),
                  ),
                  // Premium Verified Badge
                  if (product.verified == true)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified, color: Color(0xFF1D9BF0), size: 14),
                            const SizedBox(width: 4),
                            Text(
                              'VERIFIED',
                              style: GoogleFonts.outfit(
                                fontSize: 9, 
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName ?? '',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.foreground,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(LucideIcons.mapPin, size: 12, color: AppColors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${product.city ?? "Gujarat"}, ${product.state ?? "IN"}',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 14),
                    // Glassy Price Section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '₹${product.price ?? "Contact"}',
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          Text(
                            ' / ${product.priceUnit ?? "Unit"}',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 14),
                    // Refined Company Info
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                          ),
                          child: CircleAvatar(
                            radius: 11,
                            backgroundColor: AppColors.primary,
                            backgroundImage: product.companyLogo != null 
                              ? NetworkImage(product.companyLogo!) 
                              : null,
                            child: product.companyLogo == null 
                              ? Text(
                                  (product.companyName ?? "C").substring(0, 1).toUpperCase(),
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                                )
                              : null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            product.companyName ?? 'Company',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.foreground,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    // Stylized Action Buttons
                    Row(
                      children: [
                        _buildSmallActionButton(LucideIcons.phone, Colors.white, AppColors.primary, onCallClick),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onInquiryClick,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              elevation: 0,
                            ),
                            child: Text(
                              'SEND INQUIRY',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallActionButton(IconData icon, Color bg, Color border, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border),
        ),
        child: Icon(icon, size: 16, color: AppColors.primaryDark),
      ),
    );
  }

}
