import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/ui/screens/station/widgets/book_confirmation_sheet.dart';

class StationViewModel extends ChangeNotifier {
  StationViewModel({required StationRepository repository})
      : _repository = repository;

  final StationRepository _repository;
  Station? _station;
  bool _isLoading = false;
  String? _errorMessage;

  Station? get station => _station;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadStationDetail({String? stationId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final stations = await _repository.getStations();
      if (stations.isEmpty) {
        throw StateError('No stations found');
      }

      _station = stationId == null
          ? stations.first
          : stations.firstWhere(
              (station) => station.id == stationId,
              orElse: () => stations.first,
            );
    } catch (error) {
      _errorMessage = error.toString();
      _station = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Dock> getAvailableDocks(Station station) {
    return station.docks
        .where((dock) => dock.bike?.status == BikeStatus.available)
        .toList();
  }

  void showBookConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BookConfirmationSheet(),
    );
  }
}