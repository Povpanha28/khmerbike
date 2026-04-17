import 'package:flutter/material.dart';
import 'package:khmerbike/ui/screens/map_station/viewmodel/map_viewmodel.dart';
import 'package:khmerbike/ui/states/station_state.dart';
import 'package:khmerbike/ui/screens/map_station/widgets/map_station_content.dart';
import 'package:provider/provider.dart';

class MapStationScreen extends StatelessWidget {
  const MapStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stationState = context.read<StationState>();
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(stationState: stationState),
      child: const MapStationContent(),
    );
  }
}
