import 'package:flutter/material.dart';
import 'package:khmerbike/ui/screens/map_station/viewmodel/map_viewmodel.dart';
import 'package:khmerbike/ui/screens/map_station/widgets/custom_map.dart';
import 'package:provider/provider.dart';

class MapStationContent extends StatelessWidget {
  const MapStationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final vm = context.watch<MapViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          CustomMap(
            stations: vm.stations,
            initialPosition: vm.initialPosition,
            onMapCreated: vm.setMapController,
          ),

          /// 🔍 Search bar
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Search location...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🎯 Floating button
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              onPressed: vm.goToInitial,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
