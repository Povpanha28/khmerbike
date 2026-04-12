import 'package:khmerbike/models/bike_pass.dart';

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }
}
