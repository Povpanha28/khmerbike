import 'package:flutter/material.dart';
import 'package:khmerbike/models/subscription_info.dart';
import 'package:khmerbike/ui/screens/subscription/view_model/subscription_view_model.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/tab/widgets/subscription_detail_modal.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/tab/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

class SubscriptionInfoTab extends StatefulWidget {
  const SubscriptionInfoTab();

  @override
  State<SubscriptionInfoTab> createState() => _SubscriptionInfoTabState();
}

class _SubscriptionInfoTabState extends State<SubscriptionInfoTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionViewModel>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          itemCount: viewModel.subscriptionPlans.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final pass = viewModel.subscriptionPlans[index];
            return SubscriptionCard(
              pass: pass,
              onTap: () => _showPassDetailModal(context, pass),
            );
          },
        );
      },
    );
  }

  Future<void> _showPassDetailModal(
    BuildContext context,
    SubscriptionInfo pass,
  ) async {
    final viewModel = context.read<SubscriptionViewModel>();
    if (mounted) {
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
}
