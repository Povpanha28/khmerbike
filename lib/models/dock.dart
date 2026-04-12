import 'package:khmerbike/models/bike.dart';

class Dock {
  final String id;
  final Bike? bike;

  Dock({required this.id, this.bike});

  @override
  String toString() {
    return 'Dock{id: $id,  bike: $bike}';
  }
}
