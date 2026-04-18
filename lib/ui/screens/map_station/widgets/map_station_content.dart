import 'package:flutter/material.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/ui/screens/map_station/viewmodel/map_viewmodel.dart';
import 'package:khmerbike/ui/screens/map_station/widgets/custom_map.dart';
import 'package:khmerbike/ui/screens/map_station/widgets/go_init_button.dart';
import 'package:khmerbike/ui/screens/map_station/widgets/searchbar.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';
import 'package:khmerbike/ui/utils/async_value.dart';
import 'package:provider/provider.dart';

class MapStationContent extends StatelessWidget {
  const MapStationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Consumer<MapViewModel>(
      builder: (context, vm, _) {
        final AsyncValue<List<Station>> stationsValue = vm.stationsValue;

        return Scaffold(
          body: Stack(
            children: [
              // Map
              CustomMap(
                stations: stationsValue.data ?? [],
                availableBikeCounts: vm.availableBikeCounts,
                initialPosition: vm.initialPosition,
                onMapCreated: vm.setMapController,
              ),

              // Loading
              if (stationsValue.state == AsyncValueState.loading)
                const Center(child: CircularProgressIndicator()),

              // Error
              if (stationsValue.state == AsyncValueState.error)
                Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Failed to load stations'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: vm.reload,
                                child: const Text('Retry'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () =>
                                    FocusScope.of(context).unfocus(),
                                child: const Text('Dismiss'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ///  Search bar
              Searchbar(controller: controller),

              ///  Floating button
              GoInitButton(goToInitial: vm.goToInitial),
            ],
          ),
        );
      },
    );
  }
}
