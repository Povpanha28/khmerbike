import 'package:khmerbike/models/subscription_info.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionInfo>> getSubscriptionInfo();
  Future<SubscriptionInfo?> getActivePass();
  Future<void> buyPass(String passId);
  Future<void> cancelSubscription();
}