import 'package:intl/intl.dart';

class Subscription {
  final String id;
  final String subInfoId;
  final DateTime purchasedAt;
  final int durationDays;

  Subscription({
    required this.id,
    required this.subInfoId,
    required this.purchasedAt,
    required this.durationDays,
  });

  DateTime get expiredAt => purchasedAt.add(Duration(days: durationDays));

  bool get isExpired => DateTime.now().isAfter(expiredAt);

  int get expiredInDays {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expiryDay = DateTime(expiredAt.year, expiredAt.month, expiredAt.day);
    return expiryDay.difference(today).inDays;
  }

  String getExpiredDay([String pattern = 'dd/MM/yyyy']) {
    return DateFormat(pattern).format(expiredAt);
  }

  @override
  String toString() {
    return 'Subscription{id: $id, subInfoId: $subInfoId, purchasedAt: $purchasedAt, durationDays: $durationDays, expiredAt: $expiredAt}';
  }
}