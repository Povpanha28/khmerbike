import 'package:flutter/material.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

class Searchbar extends StatelessWidget {
  final TextEditingController controller;
  const Searchbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(color: AppTheme.textPrimary, blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Search location...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
