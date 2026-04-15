import 'package:khmerbike/data/dtos/bike_dto.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/location.dart';
import 'package:khmerbike/models/station.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String latKey = 'lat';
  static const String lngKey = 'lng';
  static const String docksKey = 'docks';

  static Station fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[latKey] is num);
    assert(json[lngKey] is num);

    final List<Dock> docks = [];
    final dynamic docksJson = json[docksKey];

    if (docksJson is Map<String, dynamic>) {
      for (final entry in docksJson.entries) {
        final dynamic bikeJson = entry.value['bike'];
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
    );
  }

  static Map<String, dynamic> toJson(Station station) {
    final Map<String, dynamic> docksJson = {};

    for (final dock in station.docks) {
      docksJson[dock.id] = {
        'bike': dock.bike == null
            ? null
            : {
                'id': dock.bike!.id,
                ...BikeDto.toJson(dock.bike!),
              },
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
