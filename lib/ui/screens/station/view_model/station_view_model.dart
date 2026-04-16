import 'package:flutter/material.dart';
import 'package:khmerbike/ui/states/subscription_state.dart';
import 'package:khmerbike/models/subscription.dart';
import 'package:provider/provider.dart'; // Added for ChangeNotifierProvider.value
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/ui/screens/station/widgets/book_confirmation_sheet.dart';

class StationViewModel extends ChangeNotifier {
  StationViewModel({
    required StationRepository repository,
    required SubscriptionState subscriptionState,
  }) : _repository = repository,
       _subscriptionState = subscriptionState {
    _subscriptionState.addListener(_onSubscriptionChanged);
  }

  final StationRepository _repository;
  final SubscriptionState _subscriptionState;
  Station? _station;
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedDockId;

  /// Expose subscription from the subscription state
  Subscription? get subscription => _subscriptionState.subscription;

  bool get hasActiveSubscription => subscription != null;

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

  void _onSubscriptionChanged() {
    // Forward subscription changes to any listeners of this view model.
    notifyListeners();
  }

  @override
  void dispose() {
    _subscriptionState.removeListener(_onSubscriptionChanged);
    super.dispose();
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

  String getSubscriptionType() {
    return _subscriptionState.getSubscriptionType(subscription);
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
        child: BookConfirmationSheet(subscriptionType: getSubscriptionType()),
      ),
    );
  }
}
