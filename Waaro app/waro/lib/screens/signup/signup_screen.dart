import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/app_text_field.dart';
import 'package:waro/widgets/common/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _company = TextEditingController();
  final _password = TextEditingController();
  final List<String> _roles = const [
    'Manufacturer',
    'Distributor',
    'Wholesaler',
    'Trader',
    'Retailer',
    'Service Provider',
  ];
  String _role = 'Manufacturer';
  bool _obscure = true;
  bool _accept = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Get.back(),
        ),
        title: const Text('Create account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Join the network',
                  style: GoogleFonts.plusJakartaSans(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.5),
                ),
                const SizedBox(height: 6),
                Text(
                  'Free signup. No hidden cost. Connect with verified buyers and sellers.',
                  style: GoogleFonts.plusJakartaSans(fontSize: 13.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500, height: 1.45),
                ),
                const SizedBox(height: 28),
                AppTextField(controller: _name, label: 'Full name', hint: 'Your name', prefixIcon: LucideIcons.user, validator: _req),
                const SizedBox(height: 16),
                AppTextField(controller: _company, label: 'Company name', hint: 'Your business', prefixIcon: LucideIcons.briefcase),
                const SizedBox(height: 16),
                AppTextField(controller: _email, label: 'Email', hint: 'name@company.com', prefixIcon: LucideIcons.mail, keyboardType: TextInputType.emailAddress, validator: _req),
                const SizedBox(height: 16),
                AppTextField(controller: _mobile, label: 'Mobile number', hint: '+91 9000000000', prefixIcon: LucideIcons.phone, keyboardType: TextInputType.phone, validator: _req),
                const SizedBox(height: 16),
                _buildRolePicker(),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _password,
                  label: 'Password',
                  hint: 'At least 6 characters',
                  prefixIcon: LucideIcons.lock,
                  obscure: _obscure,
                  validator: (v) => v == null || v.length < 6 ? 'Min 6 characters' : null,
                  suffix: IconButton(
                    icon: Icon(_obscure ? LucideIcons.eyeOff : LucideIcons.eye, size: 18, color: AppColors.textMuted),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _accept,
                      onChanged: (v) => setState(() => _accept = v ?? false),
                      activeColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'I agree to the Terms of Service and Privacy Policy.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Create account',
                  loading: _loading,
                  variant: PrimaryButtonVariant.dark,
                  onPressed: _submit,
                ),
                const SizedBox(height: 18),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13.5, fontWeight: FontWeight.w500),
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign in',
                          style: GoogleFonts.plusJakartaSans(color: AppColors.foreground, fontWeight: FontWeight.w800),
                          recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _req(String? v) => (v == null || v.isEmpty) ? 'Required' : null;

  Widget _buildRolePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'I am a',
            style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _roles
              .map((r) => ChoiceChip(
                    label: Text(r),
                    selected: _role == r,
                    onSelected: (_) => setState(() => _role = r),
                    labelStyle: GoogleFonts.plusJakartaSans(
                      color: _role == r ? AppColors.primary : AppColors.foreground,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_accept) {
      Get.snackbar('Hold on', 'Please accept the terms to continue');
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1100));
    setState(() => _loading = false);
    Get.snackbar('Welcome to waaro', 'Account created. Please sign in.');
    Get.back();
  }
}
