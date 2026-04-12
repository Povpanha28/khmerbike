enum BikeStatus { available, inUse, maintenance }

class Bike {
  final String id;
  final BikeStatus status;

  Bike({required this.id, required this.status});

  @override
  String toString() {
    return 'Bike{id: $id, status: $status}';
  }
}
