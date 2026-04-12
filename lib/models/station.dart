import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/location.dart';

class Station {
  final String id;
  final String name;
  final Location location;
  List<Bike>? availableBikes;
  final int capacity;

  Station({
    required this.id,
    required this.name,
    required this.location,
    this.availableBikes,
    required this.capacity,
  });

  @override
  String toString() {
    return 'Station{id: $id, name: $name, location: $location, availableBikes: $availableBikes}';
  }
}
