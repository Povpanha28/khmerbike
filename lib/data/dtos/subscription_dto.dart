import 'package:khmerbike/models/subscription.dart';

class SubscriptionDto {
  static const String subInfoIdKey = 'subInfoId';
  static const String purchasedAtKey = 'purchasedAt';
  static const String durationDaysKey = 'durationDays';

  static Subscription fromJson(String id, Map<String, dynamic> json) {
    assert(json[subInfoIdKey] is String);
    assert(json[purchasedAtKey] is String);
    assert(json[durationDaysKey] is int);

    return Subscription(
      id: id,
      subInfoId: json[subInfoIdKey] as String,
      purchasedAt: DateTime.parse(json[purchasedAtKey] as String),
      durationDays: json[durationDaysKey] as int,
    );
  }

  static Map<String, dynamic> toJson(Subscription subscription) {
    return {
      subInfoIdKey: subscription.subInfoId,
      purchasedAtKey: subscription.purchasedAt.toIso8601String(),
      durationDaysKey: subscription.durationDays,
    };
  }
}
