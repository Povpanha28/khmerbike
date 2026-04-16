import 'package:khmerbike/data/dtos/bike_dto.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/location.dart';
import 'package:khmerbike/models/station.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String latKey = 'lat';
  static const String lngKey = 'lng';
  static const String docksKey = 'docks';
  static const String addressKey = 'address';
  static const String totalDocksKey = 'totalDocks';
  static const String isActiveKey = 'isActive';

  static Station fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[latKey] is num);
    assert(json[lngKey] is num);

    final List<Dock> docks = [];
    final dynamic docksJson = json[docksKey];

    // Support two dock formats:
    // 1) Map of dockId -> { 'bike': { ... } }
    // 2) List of single-entry maps: [{ 'dock001': { 'bikeId': 'bike_001' } }, ...]
    if (docksJson is Map<String, dynamic>) {
      for (final entry in docksJson.entries) {
        final dynamic value = entry.value;

        // value may be:
        // - { 'bike': { 'id': 'bike_001', 'status': 'available' } }
        // - { 'id': 'bike_001', 'status': 'available' } (inline bike)
        // - { 'bikeId': 'bike_001', 'status': 'available' } (legacy format)
        Map<String, dynamic>? bikeJson;
        if (value is Map<String, dynamic>) {
          if (value.containsKey('bike') &&
              value['bike'] is Map<String, dynamic>) {
            bikeJson = Map<String, dynamic>.from(value['bike']);
          } else if (value.containsKey('id') && value['id'] is String) {
            bikeJson = Map<String, dynamic>.from(value);
          } else if (value.containsKey('bikeId') && value['bikeId'] is String) {
            bikeJson = <String, dynamic>{'id': value['bikeId']};
            if (value.containsKey('status'))
              bikeJson['status'] = value['status'];
          }
        }

        docks.add(
          Dock(
            id: entry.key,
            bike: bikeJson is Map<String, dynamic>
                ? BikeDto.fromJson(
                    bikeJson['id'] as String,
                    Map<String, dynamic>.from(bikeJson),
                  )
                : null,
          ),
        );
      }
    } else if (docksJson is List) {
      for (final item in docksJson) {
        if (item is Map<String, dynamic> && item.keys.isNotEmpty) {
          final String dockId = item.keys.first;
          final dynamic value = item[dockId];

          Map<String, dynamic>? bikeJson;
          if (value is Map<String, dynamic>) {
            if (value.containsKey('bike') &&
                value['bike'] is Map<String, dynamic>) {
              bikeJson = Map<String, dynamic>.from(value['bike']);
            } else if (value.containsKey('id') && value['id'] is String) {
              bikeJson = Map<String, dynamic>.from(value);
            } else if (value.containsKey('bikeId') &&
                value['bikeId'] is String) {
              bikeJson = <String, dynamic>{'id': value['bikeId']};
              if (value.containsKey('status'))
                bikeJson['status'] = value['status'];
            }
          }

          docks.add(
            Dock(
              id: dockId,
              bike: bikeJson is Map<String, dynamic>
                  ? BikeDto.fromJson(
                      bikeJson['id'] as String,
                      Map<String, dynamic>.from(bikeJson),
                    )
                  : null,
            ),
          );
        }
      }
    }

    return Station(
      id: id,
      name: json[nameKey] as String,
      location: Location(
        latitude: (json[latKey] as num).toDouble(),
        longitude: (json[lngKey] as num).toDouble(),
        name: json[nameKey] as String,
      ),
      docks: docks,
      totalDocks: json[totalDocksKey] as int,
    );
  }

  static Map<String, dynamic> toJson(Station station) {
    final Map<String, dynamic> docksJson = {};

    for (final dock in station.docks) {
      docksJson[dock.id] = {
        'bike': dock.bike == null
            ? null
            : {'id': dock.bike!.id, ...BikeDto.toJson(dock.bike!)},
      };
    }

    return {
      nameKey: station.name,
      latKey: station.location.latitude,
      lngKey: station.location.longitude,
      docksKey: docksJson,
    };
  }
}
