import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription_info.dart';

class SubscriptionRepositoryMock implements SubscriptionRepository {
  final List<SubscriptionInfo> _subscriptionPlans = const [
    SubscriptionInfo(
      id: 'monthly',
      name: 'Monthly pass',
      description: 'First 60 min free per ride\nPlease use within 30 days',
      price: 19.99,
      tag: 'Most Popular',
      validityDays: 30,
    ),
    SubscriptionInfo(
      id: 'daily',
      name: 'Day pass',
      description: 'First 60 min free per ride\nPlease use within 24 hours',
      price: 1.99,
      tag: 'Subscribe & Save',
      validityDays: 1,
    ),
    SubscriptionInfo(
      id: 'annual',
      name: 'Annual pass',
      description: 'First 60 min free per ride\nPlease use within 365 days',
      price: 59.99,
      tag: 'Best Value',
      validityDays: 365,
    ),
  ];

  SubscriptionInfo? _activePass;
  DateTime? _purchasedAt;

  @override
  Future<List<SubscriptionInfo>> getSubscriptionInfo() async {
    return _subscriptionPlans;
  }

  @override
  Future<SubscriptionInfo?> getActivePass() async {
    return _activePass;
  }

  @override
  Future<void> buyPass(String passId) async {
    _activePass = _subscriptionPlans.firstWhere((p) => p.id == passId);
    _purchasedAt = DateTime.now();
  }

  @override
  Future<void> cancelSubscription() async {
    _activePass = null;
    _purchasedAt = null;
  }
}