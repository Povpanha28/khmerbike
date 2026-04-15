import 'package:khmerbike/models/bike.dart';

class BikeDto {
  static const String statusKey = 'status';

  static Bike fromJson(String id, Map<String, dynamic> json) {
    assert(json[statusKey] is String);

    return Bike(
      id: id,
      status: _statusFromString(json[statusKey] as String),
    );
  }

  static Map<String, dynamic> toJson(Bike bike) {
    return {
      statusKey: _statusToString(bike.status),
    };
  }

  static BikeStatus _statusFromString(String value) {
    switch (value) {
      case 'available':
        return BikeStatus.available;
      case 'inUse':
        return BikeStatus.inUse;
      case 'maintenance':
        return BikeStatus.maintenance;
      default:
        throw ArgumentError('Unknown bike status: $value');
    }
  }

  static String _statusToString(BikeStatus status) {
    switch (status) {
      case BikeStatus.available:
        return 'available';
      case BikeStatus.inUse:
        return 'inUse';
      case BikeStatus.maintenance:
        return 'maintenance';
    }
  }
}
