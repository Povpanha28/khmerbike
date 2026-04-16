import 'package:intl/intl.dart';

enum PassType { monthly, daily, annual, oneTime }

class BikePass {
  final String id;
  final PassType passType;
  final String name;
  final String description;
  final double price;
  final String tag;
  final int validityDays;

  // Set when the pass was purchased — used to compute validUntilLabel
  final DateTime? purchasedAt;

  const BikePass({
    required this.id,
    this.passType = PassType.oneTime,
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

  BikePass copyWith({
    String? id,
    PassType? passType,
    String? name,
    String? description,
    double? price,
    String? tag,
    int? validityDays,
    DateTime? purchasedAt,
  }) {
    return BikePass(
      id: id ?? this.id,
      passType: passType ?? this.passType,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      tag: tag ?? this.tag,
      validityDays: validityDays ?? this.validityDays,
      purchasedAt: purchasedAt ?? this.purchasedAt,
    );
  }
}
