import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

enum PrimaryButtonVariant { dark, yellow, outline, ghost }

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final PrimaryButtonVariant variant;
  final double height;
  final bool expand;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.icon,
    this.variant = PrimaryButtonVariant.dark,
    this.height = 52,
    this.expand = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final styles = _styleFor(variant);
    final child = loading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2.4, color: styles.foreground),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: styles.foreground),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: styles.foreground,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          );

    final btn = Material(
      color: styles.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height),
        side: styles.border ?? BorderSide.none,
      ),
      child: InkWell(
        onTap: loading ? null : onPressed,
        borderRadius: BorderRadius.circular(height),
        child: Container(
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );

    if (width != null) return SizedBox(width: width, child: btn);
    return expand ? SizedBox(width: double.infinity, child: btn) : btn;
  }

  _Style _styleFor(PrimaryButtonVariant v) {
    switch (v) {
      case PrimaryButtonVariant.yellow:
        return _Style(background: AppColors.primary, foreground: AppColors.foreground);
      case PrimaryButtonVariant.outline:
        return _Style(
          background: AppColors.surface,
          foreground: AppColors.foreground,
          border: const BorderSide(color: AppColors.border),
        );
      case PrimaryButtonVariant.ghost:
        return _Style(background: AppColors.surfaceAlt, foreground: AppColors.foreground);
      case PrimaryButtonVariant.dark:
        return _Style(background: AppColors.foreground, foreground: AppColors.primary);
    }
  }
}

class _Style {
  final Color background;
  final Color foreground;
  final BorderSide? border;
  _Style({required this.background, required this.foreground, this.border});
}
