import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/bike_pass/bike_pass_repository.dart';
import 'package:khmerbike/models/bike_pass.dart';
import 'package:khmerbike/models/subscription.dart';
import 'package:khmerbike/ui/utils/async_value.dart';
import 'package:khmerbike/ui/states/subscription_state.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final BikePassRepository _bikePassRepository;
  final SubscriptionState _subscriptionState;

  SubscriptionViewModel({
    required BikePassRepository bikePassRepository,
    required SubscriptionState subscriptionState,
  }) : _bikePassRepository = bikePassRepository,
       _subscriptionState = subscriptionState {
    loadData();
    _subscriptionState.addListener(_onSubscriptionChanged);
  }

  AsyncValue<List<BikePass>> _subscriptionPlansState = AsyncValue.loading();
  Object? _actionError;

  AsyncValue<List<BikePass>> get subscriptionPlansState => _subscriptionPlansState;

  List<BikePass> get subscriptionPlans => _subscriptionPlansState.data ?? [];
  Subscription? get activeSubscription => _subscriptionState.subscription;

  BikePass? get activePass {
    final active = activeSubscription;
    if (active == null) return null;

    try {
      final plan = subscriptionPlans.firstWhere(
        (p) => p.id == active.subInfoId,
      );
      return plan.copyWith(purchasedAt: active.purchasedAt);
    } catch (_) {
      return null;
    }
  }

  bool get isLoading {
    return _subscriptionPlansState.state == AsyncValueState.loading ||
        _subscriptionState.isLoading;
  }

  Object? get error {
    return _subscriptionPlansState.error ??
        _subscriptionState.error ??
        _actionError;
  }

  void _onSubscriptionChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _subscriptionState.removeListener(_onSubscriptionChanged);
    super.dispose();
  }

  Future<void> loadData() async {
    _subscriptionPlansState = AsyncValue.loading();
    notifyListeners();

    try {
      final plans = await _bikePassRepository.getBikePass();

      _subscriptionPlansState = AsyncValue.success(plans);
      _actionError = null;
    } catch (e) {
      _subscriptionPlansState = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> buyPass(BikePass pass) async {
    notifyListeners();

    try {
      await _subscriptionState.buyPass(pass.id, pass.validityDays);
      _actionError = null;
    } catch (e) {
      _actionError = e;
    }

    notifyListeners();
  }

  Future<void> cancelSubscription() async {
    notifyListeners();

    try {
      await _subscriptionState.cancelActiveSubscription();
      _actionError = null;
    } catch (e) {
      _actionError = e;
    }

    notifyListeners();
  }
}
