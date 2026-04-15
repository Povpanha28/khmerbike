import 'package:flutter/material.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

class CardStyle {
  final Color bgColor;
  final Color borderColor;
  final double borderWidth;
  final Color tagBg;
  final Color tagText;
  final Color darkText;
  final Color midText;

  const CardStyle({
    required this.bgColor,
    required this.borderColor,
    required this.borderWidth,
    required this.tagBg,
    required this.tagText,
    required this.darkText,
    required this.midText,
  });

  factory CardStyle.fromTag(String tag) {
    // All cards use unified styling
    return const CardStyle(
      // White card background for all
      bgColor: Color(0xFFFFFFFF),
      // Light gray border for all
      borderColor: Color(0xFFE5E7EB),
      borderWidth: 1.0,
      // Green badge only for "Most Popular"
      tagBg: AppTheme.primaryGreen,
      tagText: Colors.white,
      // Consistent dark text
      darkText: AppTheme.textPrimary,
      // Consistent mid text
      midText: AppTheme.textSecondary,
    );
  }
}
