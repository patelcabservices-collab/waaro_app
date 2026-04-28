import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/app_text_field.dart';
import 'package:waro/widgets/common/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = TextEditingController(text: 'Your Name');
  final _company = TextEditingController(text: 'Your Company');
  final _email = TextEditingController(text: 'you@company.com');
  final _phone = TextEditingController(text: '+91 9000000000');
  final _city = TextEditingController(text: 'Mumbai');
  final _bio = TextEditingController(text: 'B2B trader specialising in industrial supplies.');
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Edit profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.primary.withOpacity(0.25),
                  child: Text('Y',
                      style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.foreground)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.foreground,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                    child: const Icon(LucideIcons.camera, color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(controller: _name, label: 'Full name', prefixIcon: LucideIcons.user),
          const SizedBox(height: 14),
          AppTextField(controller: _company, label: 'Company', prefixIcon: LucideIcons.briefcase),
          const SizedBox(height: 14),
          AppTextField(controller: _email, label: 'Email', prefixIcon: LucideIcons.mail, keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 14),
          AppTextField(controller: _phone, label: 'Mobile', prefixIcon: LucideIcons.phone, keyboardType: TextInputType.phone),
          const SizedBox(height: 14),
          AppTextField(controller: _city, label: 'City', prefixIcon: LucideIcons.mapPin),
          const SizedBox(height: 14),
          AppTextField(controller: _bio, label: 'About', minLines: 3, maxLines: 5, prefixIcon: LucideIcons.fileText),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Save changes',
            loading: _saving,
            variant: PrimaryButtonVariant.dark,
            onPressed: () async {
              setState(() => _saving = true);
              await Future.delayed(const Duration(milliseconds: 800));
              setState(() => _saving = false);
              Get.back();
              Get.snackbar('Saved', 'Profile updated successfully');
            },
          ),
        ],
      ),
    );
  }
}
