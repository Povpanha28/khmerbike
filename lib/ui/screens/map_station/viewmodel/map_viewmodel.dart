import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  MapViewModel({required this.stationRepository}) {
    _init();
  }

  final LatLng initialPosition = const LatLng(11.5564, 104.9282);

  List<Station> _stations = [];
  List<Station> get stations => _stations;

  GoogleMapController? _mapController;

  void _init() async {
    _stations = await stationRepository.getStations();
    notifyListeners();
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
