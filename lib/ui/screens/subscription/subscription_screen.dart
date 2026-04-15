import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/ui/screens/subscription/view_model/subscription_view_model.dart';
import 'package:khmerbike/ui/screens/subscription/widgets/subscription_content.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriptionRepository = context.read<SubscriptionRepository>();

    return ChangeNotifierProvider(
      create: (_) =>
          SubscriptionViewModel(subscriptionRepository: subscriptionRepository),
      child: const SubscriptionContent(),
    );
  }
}
