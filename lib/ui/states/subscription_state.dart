import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription.dart';

class SubscriptionState extends ChangeNotifier {
  final SubscriptionRepository subscriptionRepo;
  SubscriptionState({required this.subscriptionRepo}) {
    _loadSubscription();
  }

  Subscription? get subscription => _subscription;
  bool get isLoading => _isLoading;
  Object? get error => _error;

  Subscription? _subscription;
  bool _isLoading = true;
  Object? _error;

  void _loadSubscription() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _subscription = await subscriptionRepo.getActiveSubscription();
    } catch (e) {
      _error = e;
      _subscription = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Purchase a pass and refresh state
  Future<void> buyPass(String subInfoId, int durationDays) async {
    await subscriptionRepo.buyPass(subInfoId, durationDays);
    _subscription = await subscriptionRepo.getActiveSubscription();
    _error = null;
    notifyListeners();
  }

  /// Cancel the active subscription and refresh state
  Future<void> cancelActiveSubscription() async {
    await subscriptionRepo.cancelSubscription();
    _subscription = null;
    _error = null;
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
