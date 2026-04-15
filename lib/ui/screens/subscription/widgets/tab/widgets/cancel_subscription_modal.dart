import 'package:flutter/material.dart';
import 'package:khmerbike/models/subscription_info.dart';
import 'package:khmerbike/ui/screens/subscription/view_model/subscription_view_model.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';
import 'package:khmerbike/ui/widget/detail_row.dart';
import 'package:khmerbike/ui/widget/app_buttons.dart';

class CancelSubscriptionModal {
  static void show(
    BuildContext context,
    SubscriptionViewModel viewModel,
    SubscriptionInfo activePass,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: const BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Red header (danger) ────────────────────────────────────
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.errorRed,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CANCEL PASS',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      activePass.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You'll lose access immediately.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Content ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    // Plan details
                    const Text(
                      'Plan Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DetailRow(label: 'Plan', value: activePass.name),
                    const SizedBox(height: 12),
                    DetailRow(
                      label: 'Valid until',
                      value: activePass.validUntilLabel,
                    ),
                    const SizedBox(height: 12),
                    DetailRow(
                      label: 'Price',
                      value: '\$${activePass.price.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 20),
                    Divider(color: AppTheme.borderColor, height: 1),
                    const SizedBox(height: 20),

                    // Action buttons
                    DangerOutlinedButton(
                      label: 'Yes, cancel',
                      fontSize: 16,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: () async {
                        await viewModel.cancelSubscription();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    SecondaryButton(
                      label: 'Keep pass',
                      fontSize: 16,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
