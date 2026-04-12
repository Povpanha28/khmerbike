import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription.dart';

class SubscriptionRepositoryMock implements SubscriptionRepository {
  final List<Subscription> _subscriptions = [
    Subscription(id: '1', userId: 'user1', bikePassId: 'pass1'),
    Subscription(id: '2', userId: 'user2', bikePassId: 'pass2'),
  ];

  @override
  Future<void> addSubscription(Subscription subscription) async {
    // Mock implementation, no actual update logic
    print('Added subscription: $subscription');
  }

  @override
  Future<Subscription?> getSubscription(String userId) async {
    return _subscriptions.firstWhere(
      (sub) => sub.userId == userId,
      orElse: () => null!,
    );
  }
}
