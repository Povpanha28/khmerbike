import 'package:flutter/material.dart';
import 'package:khmerbike/models/bike_pass.dart';
import 'package:khmerbike/models/subscription.dart';
import 'package:khmerbike/ui/screens/subscription/view_model/subscription_view_model.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/tab/widgets/subscription_detail_modal.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/tab/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

class SubscriptionInfoTab extends StatelessWidget {
  const SubscriptionInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null && viewModel.subscriptionPlans.isEmpty) {
          return const Center(
            child: Text(
              'Failed to load subscription plans.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          itemCount: viewModel.subscriptionPlans.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final pass = viewModel.subscriptionPlans[index];
            final activeSubscription = viewModel.activeSubscription;
            final isActive = activeSubscription?.subInfoId == pass.id;
            return SubscriptionCard(
              pass: pass,
              isActive: isActive,
              onTap: () =>
                  _handlePassTap(context, viewModel, activeSubscription, pass),
            );
          },
        );
      },
    );
  }

  void _handlePassTap(
    BuildContext context,
    SubscriptionViewModel viewModel,
    Subscription? activeSubscription,
    BikePass pass,
  ) {
    if (activeSubscription != null && !activeSubscription.isExpired) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            content: Text(
              'You can buy one pass at a time. Please cancel your pass or wait until it expired.',
            ),
          ),
        );
      return;
    }

    _showPassDetailModal(context, viewModel, pass);
  }

  Future<void> _showPassDetailModal(
    BuildContext context,
    SubscriptionViewModel viewModel,
    BikePass pass,
  ) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) =>
          SubscriptionDetailModal(pass: pass, viewModel: viewModel),
    );
  }
}
