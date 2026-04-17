import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/ui/utils/async_value.dart';

class StationState extends ChangeNotifier {
  final StationRepository repository;
  StationState({required this.repository}) {
    loadStations();
  }

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();

  List<Station> get stations => stationsValue.data ?? [];

  Future<void> loadStations() async {
    stationsValue = AsyncValue.loading();
    notifyListeners();
    try {
      final result = await repository.getStations();
      stationsValue = AsyncValue.success(result);
      notifyListeners();
    } catch (e) {
      stationsValue = AsyncValue.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> reload() async => loadStations();

  int getStationAvailableBikes(String stationId) {
    final station = getStationById(stationId);
    if (station == null) return 0;

    int count = 0;
    for (var dock in station.docks) {
      if (dock.bike != null && dock.bike!.status == BikeStatus.available) {
        count++;
      }
    }
    return count;
  }

  Station? getStationById(String id) {
    try {
      return stations.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Update bike status remotely and update local stations in-place.
  Future<void> updateBikeStatus({
    required String stationId,
    required String dockId,
    required BikeStatus status,
  }) async {
    await repository.updateBikeStatus(
      stationId: stationId,
      dockId: dockId,
      status: status,
    );

    final List<Station> current = stations;
    final int sIndex = current.indexWhere((s) => s.id == stationId);
    if (sIndex == -1) return;
    final station = current[sIndex];
    final int dIndex = station.docks.indexWhere((d) => d.id == dockId);
    if (dIndex == -1) return;

    final dock = station.docks[dIndex];
    final bike = dock.bike;
    final newBike = bike != null
        ? Bike(id: bike.id, status: status)
        : Bike(id: 'unknown', status: status);
    station.docks[dIndex] = dock.copyWith(bike: newBike);

    // update stationsValue to same list instance so widgets holding references see mutation
    stationsValue = AsyncValue.success(current);
    notifyListeners();
  }
}
