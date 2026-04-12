class Subscription {
  final String id;
  final String userId;
  final String bikePassId;

  Subscription({required this.id, required this.userId, required this.bikePassId});

  @override
  String toString() {
    return 'Subscription{id: $id, userId: $userId, bikePassId: $bikePassId}';
  }
}