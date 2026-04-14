import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/ui/screens/map_station/viewmodel/map_viewmodel.dart';
import 'package:khmerbike/ui/screens/map_station/widgets/map_station_content.dart';
import 'package:provider/provider.dart';

class MapStationScreen extends StatelessWidget {
  const MapStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stationRepo = context.read<StationRepository>();
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(stationRepository: stationRepo),
      child: const MapStationContent(),
    );
  }
}
