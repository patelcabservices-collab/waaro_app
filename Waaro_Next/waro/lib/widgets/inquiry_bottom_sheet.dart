import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/models/product_model.dart';

class InquiryBottomSheet extends StatelessWidget {
  final ProductModel product;

  const InquiryBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'SEND INQUIRY',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Inquiry for: ${product.productName}',
            style: GoogleFonts.outfit(color: AppColors.grey, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildInput('Your Message', 'Enter your requirements or questions...', maxLines: 4),
          const SizedBox(height: 20),
          _buildInput('Quantity Required', 'e.g. 100 units', icon: LucideIcons.package),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Success', 
                'Inquiry sent successfully to ${product.companyName}',
                backgroundColor: Colors.black,
                colorText: AppColors.primary,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(20),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(
              'SUBMIT INQUIRY',
              style: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInput(String label, String hint, {int maxLines = 1, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5, color: AppColors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon, size: 20) : null,
            fillColor: AppColors.lightGrey.withOpacity(0.5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
