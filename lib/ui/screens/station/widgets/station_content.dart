import 'package:flutter/material.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/subscription.dart';
import 'package:khmerbike/ui/screens/station/widgets/appbar.dart';
import 'package:khmerbike/ui/screens/station/widgets/dockCard_tile.dart';
import 'package:khmerbike/ui/screens/station/widgets/sum_avail_bike.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';
import 'package:provider/provider.dart';

class StationContent extends StatelessWidget {
  const StationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StationViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (viewModel.errorMessage != null) {
          return const Scaffold(
            body: Center(child: Text('Failed to load station data')),
          );
        }

        final station = viewModel.station;
        if (station == null) {
          return const Scaffold(body: Center(child: Text('No station data')));
        }

        final availableDocks = viewModel.getAvailableDocks(station);

        return Scaffold(
          appBar: StationAppBar(
            stationName: station.name,
            locationName: station.location.name,
            subscriptionType: viewModel.getSubscriptionType(),
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SumAvailBike(count: availableDocks.length),
                    const SizedBox(height: 30),
                    _availableTitle(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: availableDocks.length,
                  itemBuilder: (context, index) {
                    final Dock dock = availableDocks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: BikeDockCard(
                        dock: dock,
                        onUnlock: () =>
                            viewModel.showBookConfirmation(context, dock.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _availableTitle() {
  return const Text(
    'Available Bike',
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1B253F),
    ),
  );
}
