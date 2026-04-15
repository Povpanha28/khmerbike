import 'package:flutter/material.dart';
import 'package:khmerbike/models/subscription_info.dart';
import 'package:khmerbike/ui/screens/subscription/view_model/subscription_view_model.dart';
import 'package:khmerbike/ui/widget/detail_row.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

class SubscriptionDetailModal extends StatelessWidget {
  final SubscriptionInfo pass;
  final SubscriptionViewModel viewModel;

  const SubscriptionDetailModal({required this.pass, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header with green background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    pass.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${pass.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pass.description,
                    style: const TextStyle(fontSize: 13, color: Color(0xFFE0F7E0)),
                  ),
                ],
              ),
            ),
            // Content sheet
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 36),
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
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const Text(
                      "What's included",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DetailRow(
                      label: 'Free ride time',
                      value: '60 min / ride',
                    ),
                    const SizedBox(height: 12),
                    DetailRow(
                      label: 'Unlimited bike unlocks',
                      value: 'Yes',
                      valueColor: AppTheme.primaryGreen,
                    ),
                    const SizedBox(height: 12),
                    DetailRow(
                      label: 'No hidden fees',
                      value: 'Yes',
                      valueColor: AppTheme.primaryGreen,
                    ),
                    const SizedBox(height: 12),
                    DetailRow(
                      label: 'Priority support',
                      value: 'Yes',
                      valueColor: AppTheme.primaryGreen,
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 24, thickness: 0.8),
                    const SizedBox(height: 20),
                    DetailRow(
                      label: 'Total price',
                      value: '\$${pass.price.toStringAsFixed(2)}',
                      valueFontSize: 18,
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await viewModel.buyPass(pass);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${pass.name} purchased!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Buy now',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
