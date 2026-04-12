import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class MapStationContent extends StatefulWidget {
  const MapStationContent({super.key});

  @override
  State<MapStationContent> createState() => _MapStationContentState();
}

class _MapStationContentState extends State<MapStationContent> {
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();

  final Set<Marker> _markers = {};
  final LatLng _initialPosition = const LatLng(11.5564, 104.9282);

  // 🔍 Search function
  Future<void> _searchLocation(String locationName) async {
    try {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(
        locationName,
      );

      if (locations.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Location not found")));
        return;
      }

      final loc = locations.first;
      LatLng position = LatLng(loc.latitude, loc.longitude);

      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 15));

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('search'),
            position: position,
            onTap: () => _showBottomSheet(locationName),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Search failed. Check internet.")),
      );
    }
  }

  // 📦 Bottom Sheet
  void _showBottomSheet(String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Available bikes: 8"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text("Rent Bike"),
              ),
            ],
          ),
        );
      },
    );
  }

  // 📍 Add sample station marker
  void _addInitialMarker() {
    _markers.add(
      Marker(
        markerId: const MarkerId('station'),
        position: _initialPosition,
        onTap: () => _showBottomSheet("Main Station"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _addInitialMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌍 Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 13,
            ),
            markers: _markers,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),

          /// 🔍 Grab-style Search Bar
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
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Search location...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _searchLocation(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🎯 Floating Action (My Location style)
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(_initialPosition, 14),
                );
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
