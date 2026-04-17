import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/ui/states/station_state.dart';
import 'package:khmerbike/ui/utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationState stationState;
  MapViewModel({required this.stationState}) {
    stationsValue = stationState.stationsValue;
    _refreshAvailableBikeCounts();
    stationState.addListener(_onStationStateChanged);
  }

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();
  Map<String, int> availableBikeCounts = {};

  final LatLng initialPosition = const LatLng(11.5564, 104.9282);

  GoogleMapController? _mapController;

  void _onStationStateChanged() {
    stationsValue = stationState.stationsValue;
    _refreshAvailableBikeCounts();
    notifyListeners();
  }

  void _refreshAvailableBikeCounts() {
    final stations = stationsValue.data ?? [];
    availableBikeCounts = {
      for (final station in stations)
        station.id: stationState.getStationAvailableBikes(station.id),
    };
  }

  int getStationAvailableBikes(String stationId) =>
      availableBikeCounts[stationId] ?? 0;

  void reload() {
    stationState.reload();
  }

  /// Set map controller
  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  /// Reset camera
  void goToInitial() {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(initialPosition, 14),
    );
  }
}
