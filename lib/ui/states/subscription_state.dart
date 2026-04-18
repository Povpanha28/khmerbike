import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription.dart';
import 'package:khmerbike/ui/utils/async_value.dart';

class SubscriptionState extends ChangeNotifier {
  final SubscriptionRepository subscriptionRepo;
  SubscriptionState({required this.subscriptionRepo}) {
    _loadSubscription();
  }

  AsyncValue<Subscription?> get subscriptionValue => _subscriptionValue;
  Subscription? get subscription => _subscriptionValue.data;
  bool get isLoading => _subscriptionValue.state == AsyncValueState.loading;
  Object? get error => _subscriptionValue.error;

  AsyncValue<Subscription?> _subscriptionValue = AsyncValue.loading();

  void _loadSubscription() async {
    _subscriptionValue = AsyncValue.loading();
    notifyListeners();

    try {
      final activeSubscription = await subscriptionRepo.getActiveSubscription();
      _subscriptionValue = AsyncValue.success(activeSubscription);
    } catch (e) {
      _subscriptionValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  /// Purchase a pass and refresh state
  Future<void> buyPass(String subInfoId, int durationDays) async {
    _subscriptionValue = AsyncValue.loading();
    notifyListeners();

    try {
      await subscriptionRepo.buyPass(subInfoId, durationDays);
      final activeSubscription = await subscriptionRepo.getActiveSubscription();
      _subscriptionValue = AsyncValue.success(activeSubscription);
    } catch (e) {
      _subscriptionValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  /// Cancel the active subscription and refresh state
  Future<void> cancelActiveSubscription() async {
    _subscriptionValue = AsyncValue.loading();
    notifyListeners();

    try {
      await subscriptionRepo.cancelSubscription();
      _subscriptionValue = AsyncValue.success(null);
    } catch (e) {
      _subscriptionValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  String getSubscriptionType(Subscription? subscription) {
    if (subscription == null) return 'No Subscription';

    switch (subscription.subInfoId) {
      case 'pass_monthly':
        return 'Monthly';
      case 'pass_day':
        return 'Daily';

      case 'pass_annual':
        return 'Yearly';

      default:
        return 'Unknown Subscription';
    }
  }
}
