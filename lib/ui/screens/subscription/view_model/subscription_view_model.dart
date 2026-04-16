import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/bike_pass/bike_pass_repository.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/bike_pass.dart';
import 'package:khmerbike/models/subscription.dart';
import 'package:khmerbike/ui/utils/async_value.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final BikePassRepository _bikePassRepository;
  final SubscriptionRepository _subscriptionRepository;

  SubscriptionViewModel({
    required BikePassRepository bikePassRepository,
    required SubscriptionRepository subscriptionRepository,
  }) : _bikePassRepository = bikePassRepository,
       _subscriptionRepository = subscriptionRepository;

  AsyncValue<List<BikePass>> _subscriptionPlansState = AsyncValue.loading();
  AsyncValue<Subscription?> _activeSubscriptionState = AsyncValue.loading();

  AsyncValue<List<BikePass>> get subscriptionPlansState =>
      _subscriptionPlansState;
  AsyncValue<Subscription?> get activeSubscriptionState =>
      _activeSubscriptionState;

  List<BikePass> get subscriptionPlans => _subscriptionPlansState.data ?? [];
  Subscription? get activeSubscription => _activeSubscriptionState.data;

  BikePass? get activePass {
    final active = activeSubscription;
    if (active == null) return null;

    try {
      final plan = subscriptionPlans.firstWhere((p) => p.id == active.subInfoId);
      return plan.copyWith(purchasedAt: active.purchasedAt);
    } catch (_) {
      return null;
    }
  }
  bool get isLoading {
    return _subscriptionPlansState.state == AsyncValueState.loading ||
        _activeSubscriptionState.state == AsyncValueState.loading;
  }

  Object? get error {
    return _subscriptionPlansState.error ?? _activeSubscriptionState.error;
  }

  Future<void> loadData() async {
    _subscriptionPlansState = AsyncValue.loading();
    _activeSubscriptionState = AsyncValue.loading();
    notifyListeners();

    try {
      final plans = await _bikePassRepository.getBikePass();
      final subscription = await _subscriptionRepository.getActiveSubscription();

      _subscriptionPlansState = AsyncValue.success(plans);
      _activeSubscriptionState = AsyncValue.success(subscription);
    } catch (e) {
      _subscriptionPlansState = AsyncValue.error(e);
      _activeSubscriptionState = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> buyPass(BikePass pass) async {
    _activeSubscriptionState = AsyncValue.loading();
    notifyListeners();

    try {
      await _subscriptionRepository.buyPass(pass.id, pass.validityDays);
      final active = await _subscriptionRepository.getActiveSubscription();
      _activeSubscriptionState = AsyncValue.success(active);
    } catch (e) {
      _activeSubscriptionState = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> cancelSubscription() async {
    _activeSubscriptionState = AsyncValue.loading();
    notifyListeners();

    try {
      await _subscriptionRepository.cancelSubscription();
      _activeSubscriptionState = AsyncValue.success(null);
    } catch (e) {
      _activeSubscriptionState = AsyncValue.error(e);
    }

    notifyListeners();
  }
}