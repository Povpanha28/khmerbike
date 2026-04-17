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

  static Map<String, dynamic>? _resolveBikeJson(
    Map<String, dynamic> value, {
    Map<String, dynamic>? bikes,
  }) {
    if (value.containsKey('bike') && value['bike'] is Map<String, dynamic>) {
      final bikeMap = Map<String, dynamic>.from(
        value['bike'] as Map<String, dynamic>,
      );
      return bikeMap['id'] is String && bikeMap['status'] is String
          ? bikeMap
          : null;
    }

    if (value.containsKey('id') &&
        value['id'] is String &&
        value['status'] is String) {
      return Map<String, dynamic>.from(value);
    }

    if (value.containsKey('bikeId') && value['bikeId'] is String) {
      final String bikeId = value['bikeId'] as String;
      // Source of truth: top-level bikes map by bikeId
      if (bikes != null && bikes[bikeId] is Map<String, dynamic>) {
        final bikeMap = Map<String, dynamic>.from(
          bikes[bikeId] as Map<String, dynamic>,
        );
        if (bikeMap['status'] is String) {
          return <String, dynamic>{'id': bikeId, ...bikeMap};
        }
      }
      // fallback only if legacy inline status exists next to bikeId
      if (value['status'] is String) {
        return <String, dynamic>{'id': bikeId, 'status': value['status']};
      }
    }

    return null;
  }

  static Station fromJson(
    String id,
    Map<String, dynamic> json, {
    Map<String, dynamic>? bikes,
  }) {
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
        // - { 'bikeId': 'bike_001' } (status resolved from top-level bikes map)
        Map<String, dynamic>? bikeJson;
        if (value is Map<String, dynamic>) {
          bikeJson = _resolveBikeJson(value, bikes: bikes);
        }

        docks.add(
          Dock(
            id: entry.key,
            bike: bikeJson != null
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
            bikeJson = _resolveBikeJson(value, bikes: bikes);
          }

          docks.add(
            Dock(
              id: dockId,
              bike: bikeJson != null
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
