import 'package:khmerbike/models/subscription.dart';

abstract class SubscriptionRepository {
  Future<Subscription?> getActiveSubscription();
  Future<void> buyPass(String subInfoId, int durationDays);
  Future<void> cancelSubscription();
}