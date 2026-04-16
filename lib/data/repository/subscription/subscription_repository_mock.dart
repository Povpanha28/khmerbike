import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription.dart';

class SubscriptionRepositoryMock implements SubscriptionRepository {
  Subscription? _activeSubscription;

  @override
  Future<Subscription?> getActiveSubscription() async {
    return _activeSubscription;
  }

  @override
  Future<void> buyPass(String subInfoId, int durationDays) async {
    _activeSubscription = Subscription(
      id: 'sub-${DateTime.now().millisecondsSinceEpoch}',
      subInfoId: subInfoId,
      purchasedAt: DateTime.now(),
      durationDays: durationDays,
    );
  }

  @override
  Future<void> cancelSubscription() async {
    _activeSubscription = null;
  }
}