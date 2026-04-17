import 'package:flutter/material.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';
import 'package:khmerbike/ui/widget/app_buttons.dart';
import 'package:khmerbike/ui/widget/app_modal_template.dart';

class NoSubscriptionBottomSheet extends StatelessWidget {
  final VoidCallback onBuySingleUse;
  final VoidCallback onViewPlans;

  const NoSubscriptionBottomSheet({
    super.key,
    required this.onBuySingleUse,
    required this.onViewPlans,
  });

  @override
  Widget build(BuildContext context) {
    return AppModalFrame(
      expandBody: false,
      bodyPadding: const EdgeInsets.fromLTRB(20, 10, 20, 22),
      bodyBorderRadius: BorderRadius.zero,
      header: AppModalHeader(
        backgroundColor: AppTheme.primaryGreen,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NO SUBSCRIPTION',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Choose a one-time ticket or view subscription plans.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFE9F9EE),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F2F4),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Single Ticket',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2A44),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'Onetime Only',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'One-time ticket for this ride.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5E5E5E),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'First 60 minutes cost \$1.60, then every extra 30 minutes costs \$0.50',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5E5E5E),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Buy and Unlock',
            onPressed: onBuySingleUse,
            fontSize: 16,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            label: 'View Subscription Plans',
            onPressed: onViewPlans,
            fontSize: 16,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ],
      ),
    );
  }
}
