import 'package:flutter/material.dart';
import 'package:khmerbike/models/subscription.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/ui/screens/station/widgets/book_confirmation_sheet.dart';
import 'package:khmerbike/ui/screens/station/widgets/no_subscription_bottom_sheet.dart';
import 'package:khmerbike/ui/screens/subscription/subscription_screen.dart';
import 'package:khmerbike/ui/states/subscription_state.dart';
import 'package:provider/provider.dart';

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

  Future<void> confirmBooking(BuildContext context) async {
    final station = _station;
    final dock = selectedDock;

    if (station == null || dock == null || dock.bike == null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _repository.updateBikeStatus(
        stationId: station.id,
        dockId: dock.id,
        status: BikeStatus.inUse,
      );

      final int dockIndex = station.docks.indexWhere((d) => d.id == dock.id);
      if (dockIndex != -1) {
        station.docks[dockIndex] = Dock(
          id: dock.id,
          bike: Bike(id: dock.bike!.id, status: BikeStatus.inUse),
        );
      }

      notifyListeners();
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bike ${dock.bike!.id} is now in use')),
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void showBookConfirmation(BuildContext context, String dockId) {
    selectDock(dockId);
    final dock = selectedDock;
    if (dock == null) {
      return;
    }

    // Check if user has an active subscription
    if (hasActiveSubscription) {
      // Show booking confirmation with pass
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ChangeNotifierProvider<StationViewModel>.value(
          value: this,
          child: BookConfirmationSheet(subscriptionType: getSubscriptionType()),
        ),
      );
    } else {
      // Show no subscription modal with options to buy single-use ticket or view plans
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (sheetContext) => NoSubscriptionBottomSheet(
          onBuySingleUse: () {
            confirmBooking(sheetContext);
          },
          onViewPlans: () {
            Navigator.pop(sheetContext);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SubscriptionScreen(),
              ),
            );
          },
        ),
      );
    }
  }

}
