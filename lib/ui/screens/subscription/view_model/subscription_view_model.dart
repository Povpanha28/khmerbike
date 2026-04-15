import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription_info.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final SubscriptionRepository _subscriptionRepository;

  SubscriptionViewModel({
    required SubscriptionRepository subscriptionRepository,
  }) : _subscriptionRepository = subscriptionRepository;

  List<SubscriptionInfo> _subscriptionPlans = [];
  SubscriptionInfo? _activePass;
  bool _isLoading = false;

  List<SubscriptionInfo> get subscriptionPlans => _subscriptionPlans;
  SubscriptionInfo? get activePass => _activePass;
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    _subscriptionPlans = await _subscriptionRepository.getSubscriptionInfo();
    _activePass = await _subscriptionRepository.getActivePass();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> buyPass(SubscriptionInfo pass) async {
    await _subscriptionRepository.buyPass(pass.id);
    _activePass = await _subscriptionRepository.getActivePass();
    notifyListeners();
  }

  Future<void> cancelSubscription() async {
    await _subscriptionRepository.cancelSubscription();
    _activePass = null;
    notifyListeners();
  }
}