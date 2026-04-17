import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';
import 'package:khmerbike/ui/widget/app_modal_template.dart';

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

        return AppModalFrame(
          expandBody: false,
          bodyPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          bodyBorderRadius: BorderRadius.zero,
          header: AppModalHeader(
            backgroundColor: AppTheme.primaryGreen,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: const Center(
              child: Text(
                'BOOK CONFIRMATION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoCard(
                  icon: Icons.pedal_bike,
                  title: 'Dock ${dock.id}',
                  subtitle: dock.bike != null
                      ? 'Bike #${dock.bike!.id}'
                      : 'No bike available',
                ),
                const SizedBox(height: 12),
                _buildInfoCard(
                  icon: Icons.location_on,
                  title: station?.name ?? 'Unknown Station',
                  subtitle: station?.location.name ?? 'Unknown Address',
                ),
                const SizedBox(height: 12),
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
                        'Using',
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
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () async {
                            final bikeId = await viewModel.confirmBooking();
                            if (!context.mounted) return;
                            if (bikeId != null) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Bike $bikeId is now in use'),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: viewModel.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Confirm Booking',
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
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFD4F3DE)),
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
