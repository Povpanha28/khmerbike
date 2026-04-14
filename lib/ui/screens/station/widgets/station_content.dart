import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/station/station_reposity_mock.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/ui/screens/station/widgets/appbar.dart';
import 'package:khmerbike/ui/screens/station/widgets/dockCard_tile.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';
import 'package:provider/provider.dart';

class StationDetailPage extends StatelessWidget {
  const StationDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          StationViewModel(repository: StationRepositoryMock())
            ..loadStationDetail(),
      child: Consumer<StationViewModel>(
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
              onBackPressed: () {},
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.pedal_bike,
                                    color: Color(0xFF22C55E),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Available Bikes',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${availableDocks.length}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        _availableTitle(),
                        const SizedBox(height: 16),
                      ],
                    ),
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
                          dockId: dock.id,
                          onUnlock: () =>
                              viewModel.showBookConfirmation(context),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
