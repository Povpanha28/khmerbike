import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khmerbike/data/dtos/subscription_dto.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/models/subscription.dart';

class SubscriptionRepositoryFirebase implements SubscriptionRepository {
  Subscription? _cachedActiveSubscription;

  final Uri subscriptionsUri = Uri.https(
    'project-flutter-da783-default-rtdb.firebaseio.com',
    '/subscriptions.json',
  );

  Future<Map<String, dynamic>> _fetchSubscriptionsJson() async {
    final http.Response response = await http.get(subscriptionsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load subscriptions');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <String, dynamic>{};
    }

    return decoded as Map<String, dynamic>;
  }

  @override
  Future<Subscription?> getActiveSubscription() async {
    if (_cachedActiveSubscription != null) {
      return _cachedActiveSubscription;
    }

    final Map<String, dynamic> subscriptionsJson = await _fetchSubscriptionsJson();
    if (subscriptionsJson.isEmpty) {
      return null;
    }

    final MapEntry<String, dynamic> firstEntry = subscriptionsJson.entries.first;
    final Subscription result = SubscriptionDto.fromJson(
      firstEntry.key,
      Map<String, dynamic>.from(firstEntry.value),
    );

    _cachedActiveSubscription = result;
    return result;
  }

  @override
  Future<void> buyPass(String subInfoId, int durationDays) async {
    final String subscriptionId = 'sub-${DateTime.now().millisecondsSinceEpoch}';
    final Subscription newSubscription = Subscription(
      id: subscriptionId,
      subInfoId: subInfoId,
      purchasedAt: DateTime.now(),
      durationDays: durationDays,
    );

    // Keep only one active subscription record. Buying a new one replaces the old one.
    final http.Response response = await http.put(
      subscriptionsUri,
      body: json.encode({
        subscriptionId: SubscriptionDto.toJson(newSubscription),
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to buy pass');
    }

    _cachedActiveSubscription = newSubscription;
  }

  @override
  Future<void> cancelSubscription() async {
    final Subscription? active = await getActiveSubscription();
    if (active == null) {
      return;
    }

    final Uri subscriptionUri = Uri.https(
      'project-flutter-da783-default-rtdb.firebaseio.com',
      '/subscriptions/${active.id}.json',
    );

    final http.Response response = await http.delete(subscriptionUri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to cancel subscription');
    }

    _cachedActiveSubscription = null;
  }
}
