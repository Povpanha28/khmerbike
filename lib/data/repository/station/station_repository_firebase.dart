import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khmerbike/data/dtos/station_dto.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/station.dart';

class StationRepositoryFirebase implements StationRepository {
  List<Station>? _cachedStations;

  final Uri stationsUri = Uri.https(
    'project-flutter-da783-default-rtdb.firebaseio.com',
    '/stations.json',
  );

  final Uri bikesUri = Uri.https(
    'project-flutter-da783-default-rtdb.firebaseio.com',
    '/bikes.json',
  );

  Future<Map<String, dynamic>> _fetchStationsJson() async {
    final http.Response response = await http.get(stationsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load stations');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <String, dynamic>{};
    }

    return decoded as Map<String, dynamic>;
  }

  @override
  Future<List<Station>> getStations() async {
    if (_cachedStations != null) {
      return _cachedStations!;
    }

    final Map<String, dynamic> stationsJson = await _fetchStationsJson();

    Map<String, dynamic>? bikesJson;
    try {
      final http.Response bikesResponse = await http.get(bikesUri);
      if (bikesResponse.statusCode == 200) {
        final dynamic bikesDecoded = json.decode(bikesResponse.body);
        if (bikesDecoded != null) {
          bikesJson = Map<String, dynamic>.from(bikesDecoded as Map);
        }
      }
    } catch (_) {
      bikesJson = null;
    }

    final List<Station> result = [];
    for (final entry in stationsJson.entries) {
      result.add(
        StationDto.fromJson(
          entry.key,
          Map<String, dynamic>.from(entry.value),
          bikes: bikesJson,
        ),
      );
    }

    _cachedStations = result;
    return result;
  }

  @override
  Future<void> updateStationBikes(String stationId, List<Bike> bikes) async {
    // Station schema in current model uses docks, not a flat bike list.
    // This method updates cache only to keep interface compatibility.
    if (_cachedStations == null) {
      await getStations();
    }

    final List<Station> stations = List<Station>.from(_cachedStations ?? []);
    final int index = stations.indexWhere((s) => s.id == stationId);
    if (index == -1) {
      return;
    }

    // No direct mapping from List<Bike> to List<Dock> with current interface.
    // Keeping existing station untouched.
    _cachedStations = stations;
  }

  @override
  Future<void> updateBikeStatus({
    required String stationId,
    required String dockId,
    required BikeStatus status,
  }) async {
    if (_cachedStations == null) {
      await getStations();
    }

    final List<Station> stations = List<Station>.from(_cachedStations ?? []);
    final int stationIndex = stations.indexWhere((s) => s.id == stationId);
    if (stationIndex == -1) {
      throw Exception('Station not found: $stationId');
    }

    final Station station = stations[stationIndex];
    final int dockIndex = station.docks.indexWhere((d) => d.id == dockId);
    if (dockIndex == -1) {
      throw Exception('Dock not found: $dockId');
    }

    final Dock currentDock = station.docks[dockIndex];
    final Bike? bike = currentDock.bike;
    if (bike == null) {
      throw Exception('Bike not found in dock: $dockId');
    }

    // Update canonical bike status record (top-level bikes table)
    final Uri statusUri = Uri.https(
      'project-flutter-da783-default-rtdb.firebaseio.com',
      '/bikes/${bike.id}/status.json',
    );

    final http.Response response = await http.put(
      statusUri,
      body: json.encode(status.name),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update bike status');
    }

    // Mutate existing dock bike status in cache only (do not create new dock nodes remotely)
    station.docks[dockIndex] = Dock(
      id: currentDock.id,
      bike: Bike(id: bike.id, status: status),
    );

    _cachedStations = stations;
  }
}
