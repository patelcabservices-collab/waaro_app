import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/app_text_field.dart';
import 'package:waro/widgets/common/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _auth = Get.find<AuthController>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Hero(tag: 'logo', child: SvgPicture.asset('assets/images/logo.svg', width: 130)),
                ),
                const SizedBox(height: 36),
                Text('Welcome back', style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.5)),
                const SizedBox(height: 6),
                Text(
                  'Sign in to continue building your B2B network.',
                  style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _email,
                  label: 'Email or Mobile',
                  hint: 'you@company.com',
                  prefixIcon: LucideIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 18),
                AppTextField(
                  controller: _password,
                  label: 'Password',
                  hint: 'Enter your password',
                  prefixIcon: LucideIcons.lock,
                  obscure: _obscure,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  suffix: IconButton(
                    icon: Icon(_obscure ? LucideIcons.eyeOff : LucideIcons.eye, size: 18, color: AppColors.textMuted),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.snackbar('Forgot password', 'Reset link will be sent to your email'),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(() => PrimaryButton(
                      label: 'Sign In',
                      loading: _auth.isLoading.value,
                      variant: PrimaryButtonVariant.dark,
                      onPressed: _handleLogin,
                    )),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(child: Divider(color: AppColors.borderSoft)),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('or')),
                    Expanded(child: Divider(color: AppColors.borderSoft)),
                  ],
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Continue with Google',
                  variant: PrimaryButtonVariant.outline,
                  icon: LucideIcons.chrome,
                  onPressed: () => Get.snackbar('Coming soon', 'Google sign-in is on the way'),
                ),
                const SizedBox(height: 24),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13.5, fontWeight: FontWeight.w500),
                      children: [
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Sign up',
                          style: GoogleFonts.plusJakartaSans(color: AppColors.foreground, fontWeight: FontWeight.w800),
                          recognizer: _signupGesture,
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

  late final _signupGesture = TapGestureRecognizer()..onTap = () => Get.toNamed('/signup');

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await _auth.login(_email.text.trim(), _password.text);
    if (ok) Get.offAllNamed('/home');
  }
}

