import 'package:flutter/material.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

/// Primary action button with green background and white text
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double fontSize;
  final EdgeInsets padding;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontSize = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Secondary action button with dark text primary background and white text
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double fontSize;
  final EdgeInsets padding;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontSize = 15,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.textPrimary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Danger action button with red outline and text
class DangerOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double fontSize;
  final EdgeInsets padding;

  const DangerOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontSize = 15,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.errorRed,
          side: BorderSide(
            color: AppTheme.errorRed.withOpacity(0.3),
            width: 1.5,
          ),
          backgroundColor: AppTheme.errorRed.withOpacity(0.05),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Subtle text button with border
class BorderedTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double fontSize;
  final EdgeInsets padding;

  const BorderedTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontSize = 15,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.textSecondary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: AppTheme.borderColor,
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
