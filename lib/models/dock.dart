import 'package:khmerbike/models/bike.dart';

class Dock {
  final String id;
  final Bike? bike;

  Dock({required this.id, this.bike});

  Dock copyWith({String? id, Bike? bike}) {
    return Dock(id: id ?? this.id, bike: bike ?? this.bike);
  }

  @override
  String toString() {
    return 'Dock{id: $id,  bike: $bike}';
  }
}
