import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Premium Mesh-like Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.05),
                    AppColors.white,
                    AppColors.primary.withOpacity(0.1),
                    AppColors.white,
                  ],
                ),
              ),
            ),
          ),
          // Animated Mesh Particles logic (Simplified as decorative blobs)
          Positioned(
            top: -100,
            right: -100,
            child: _buildDecorativeBlob(250, AppColors.primary.withOpacity(0.15)),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildDecorativeBlob(200, AppColors.primary.withOpacity(0.1)),
          ),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Glassy Form Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white.withOpacity(0.5)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'SIGN IN',
                                  style: GoogleFonts.outfit(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.foreground,
                                    letterSpacing: 1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),
                                _buildTextField(
                                  controller: _emailController,
                                  hint: 'EMAIL OR MOBILE',
                                  icon: LucideIcons.user,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  controller: _passwordController,
                                  hint: 'PASSWORD',
                                  icon: LucideIcons.lock,
                                  isPassword: true,
                                  obscure: _obscurePassword,
                                  onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                                ),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'FORGOT PASSWORD?',
                                      style: GoogleFonts.outfit(
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 11,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Obx(() => ElevatedButton(
                                  onPressed: _authController.isLoading.value ? null : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: AppColors.primary,
                                    minimumSize: const Size(double.infinity, 60),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    elevation: 0,
                                  ),
                                  child: _authController.isLoading.value
                                      ? const CircularProgressIndicator(color: AppColors.primary)
                                      : Text(
                                          'CONTINUE',
                                          style: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: 1),
                                        ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggleObscure,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.foreground),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.outfit(color: AppColors.grey, fontWeight: FontWeight.w500, fontSize: 13, letterSpacing: 0.5),
          prefixIcon: Icon(icon, size: 20, color: AppColors.grey),
          suffixIcon: isPassword 
            ? IconButton(
                icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye, size: 20, color: AppColors.grey),
                onPressed: onToggleObscure,
              )
            : null,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18), 
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _authController.login(
        _emailController.text,
        _passwordController.text,
      );
      if (success) {
        Get.offAllNamed('/home');
      }
    }
  }
}
