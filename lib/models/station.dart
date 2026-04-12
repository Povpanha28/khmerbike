import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/location.dart';

class Station {
  final String id;
  final String name;
  final Location location;
  List<Dock> docks;

  Station({required this.id, required this.name, required this.location, required this.docks});

  @override
  String toString() {
    return 'Station{id: $id, name: $name, location: $location, docks: $docks}';
  }
}
