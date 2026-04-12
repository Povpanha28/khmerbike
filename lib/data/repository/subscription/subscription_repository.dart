import 'package:khmerbike/models/subscription.dart';

abstract class SubscriptionRepository {
  Future<void> addSubscription(Subscription subscription);
  Future<Subscription?> getSubscription(String userId);
}
