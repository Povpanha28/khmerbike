import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Added for ChangeNotifierProvider.value
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
  String? _selectedDockId;

  Station? get station => _station;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Get the selected dock without throwing a StateError
  Dock? get selectedDock {
    if (_station == null || _selectedDockId == null) return null;
    
    for (var dock in _station!.docks) {
      if (dock.id == _selectedDockId) return dock;
    }
    return null; // Return null safely if dock is not found
  }

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

  void selectDock(String id) {
    _selectedDockId = id;
    notifyListeners();
  }

  void showBookConfirmation(BuildContext context, String dockId) {
    selectDock(dockId);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // FIX 2: Explicitly provide 'this' instance of the ViewModel to the bottom sheet
      builder: (_) => ChangeNotifierProvider<StationViewModel>.value(
        value: this,
        child: const BookConfirmationSheet(),
      ),
    );
  }
}