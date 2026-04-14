import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/station/station_reposity_mock.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/ui/screens/station/widgets/dockCard_tile.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';
import 'package:provider/provider.dart';

class StationDetailPage extends StatelessWidget {
  const StationDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          StationViewModel(repository: StationRepositoryMock())..loadStationDetail(),
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
            return const Scaffold(
              body: Center(child: Text('No station data')),
            );
          }

          final availableDocks = viewModel.getAvailableDocks(station);

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {},
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      station.location.name,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F5F2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.credit_card,
                              color: Color(0xFF22C55E), size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Monthly',
                            style: TextStyle(
                              color: Color(0xFF22C55E),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
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
                                  Icon(Icons.pedal_bike,
                                      color: Color(0xFF22C55E), size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Available Bikes',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11),
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
                        const Text(
                          'Available Bike',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B253F),
                          ),
                        ),
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
                          onUnlock: () => viewModel.showBookConfirmation(context),
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

