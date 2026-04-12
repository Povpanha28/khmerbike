import 'package:khmerbike/models/bike.dart';

class Dock {
  final String id;
  final String name;
  final String stationId;
  final Bike? bike;

  Dock({
    required this.id,
    required this.name,
    required this.stationId,
    this.bike,
  });

  @override
  String toString() {
    return 'Dock{id: $id, name: $name, stationId: $stationId, bike: $bike}';
  }
}
