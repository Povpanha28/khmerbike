import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription.dart';

class SubscriptionState extends ChangeNotifier {
  final SubscriptionRepository subscriptionRepo;
  SubscriptionState({required this.subscriptionRepo}) {
    _loadSubscription();
  }

  Subscription? get subscription => _subscription;

  Subscription? _subscription;

  void _loadSubscription() async {
    try {
      _subscription = await subscriptionRepo.getActiveSubscription();
      // subscription loaded into state
      notifyListeners();
    } catch (e) {
      // Handle error as needed
      notifyListeners();
    }
  }

  /// Purchase a pass and refresh state
  Future<void> buyPass(String subInfoId, int durationDays) async {
    await subscriptionRepo.buyPass(subInfoId, durationDays);
    _subscription = await subscriptionRepo.getActiveSubscription();
    notifyListeners();
  }

  /// Cancel the active subscription and refresh state
  Future<void> cancelActiveSubscription() async {
    await subscriptionRepo.cancelSubscription();
    _subscription = null;
    notifyListeners();
  }

  String getSubscriptionType(Subscription? subscription) {
    if (subscription == null) return 'No Subscription';

    switch (subscription.subInfoId) {
      case 'pass_monthly':
        return 'Monthly';
      case 'pass_daily':
        return 'Daily';

      case 'pass_yearly':
        return 'Yearly';

      default:
        return 'Unknown Subscription';
    }
  }

  // void updateSubscription(Subscription? newSubscription) {
  //   _subscription = newSubscription;
  //   notifyListeners();
  // }
}
