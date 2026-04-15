class Subscription {
  final String id;
  final String userId;
  final String subInfoId;

  Subscription({required this.id, required this.userId, required this.subInfoId});

  @override
  String toString() {
    return 'Subscription{id: $id, userId: $userId, bikePassId: $subInfoId}';
  }
}