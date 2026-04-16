import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/ui/utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  MapViewModel({required this.stationRepository}) {
    _init();
  }

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();

  final LatLng initialPosition = const LatLng(11.5564, 104.9282);

  List<Station> _stations = [];
  GoogleMapController? _mapController;

  void _init() async {
    stationsValue = AsyncValue.loading();
    notifyListeners();

    try {
      _stations = await stationRepository.getStations();
      stationsValue = AsyncValue.success(_stations);
      notifyListeners();
    } catch (e) {
      stationsValue = AsyncValue.error(e.toString());
      notifyListeners();
    }
  }

  void reload() {
    _init();
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
