import 'package:intl/intl.dart';

class SubscriptionInfo {
  final String id;
  final String name;
  final String description;
  final double price;
  final String tag;
  final int validityDays;

  // Set when the pass was purchased — used to compute validUntilLabel
  final DateTime? purchasedAt;

  const SubscriptionInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.tag,
    required this.validityDays,
    this.purchasedAt,
  });

  // e.g. "30 days", "24 hours", "365 days"
  String get validityLabel {
    if (validityDays == 1) return '24 hours';
    return '$validityDays days';
  }

  // e.g. "30/03/2027" — falls back to validity label if not yet purchased
  String get validUntilLabel {
    if (purchasedAt == null) return validityLabel;
    final expiry = purchasedAt!.add(Duration(days: validityDays));
    return DateFormat('dd/MM/yyyy').format(expiry);
  }

  SubscriptionInfo copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? tag,
    int? validityDays,
    DateTime? purchasedAt,
  }) {
    return SubscriptionInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      tag: tag ?? this.tag,
      validityDays: validityDays ?? this.validityDays,
      purchasedAt: purchasedAt ?? this.purchasedAt,
    );
  }
}