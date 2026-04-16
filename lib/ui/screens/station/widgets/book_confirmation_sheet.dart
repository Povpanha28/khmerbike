import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';

// The Bottom Sheet Widget
class BookConfirmationSheet extends StatelessWidget {
  final String subscriptionType;
  const BookConfirmationSheet({super.key, required this.subscriptionType});

  @override
  Widget build(BuildContext context) {
    return Consumer<StationViewModel>(
      builder: (context, viewModel, _) {
        final station = viewModel.station;
        final dock = viewModel.selectedDock;

        if (dock == null) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No dock selected')),
          );
        }

        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFE2E4E8), // Light grey background of bottom sheet
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24), // Balance the close button
                    const Text(
                      'Book Confirmation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B253F),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Bike Info Card
                _buildInfoCard(
                  icon: Icons.pedal_bike,
                  title: 'Dock ${dock.id}',
                  subtitle: dock.bike != null
                      ? 'Bike #${dock.bike!.id}'
                      : 'No bike available',
                ),
                const SizedBox(height: 12),

                // Location Info Card
                _buildInfoCard(
                  icon: Icons.location_on,
                  title: station?.name ?? 'Unknown Station',
                  subtitle: station?.location.name ?? 'Unknown Address',
                ),
                const SizedBox(height: 12),

                // Pass Info Card
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Using Pass',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        subscriptionType,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tap to Unlock Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Handle actual unlock logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tap to Unlock', // Changed from "Swap" for UX clarity
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper widget to build the white cards inside the bottom sheet
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD4F3DE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF22C55E)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
