import 'package:flutter/material.dart';
import 'package:khmerbike/ui/states/station_state.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';
import 'package:khmerbike/ui/screens/station/widgets/station_content.dart';
import 'package:khmerbike/ui/states/subscription_state.dart';
import 'package:provider/provider.dart';

class StationDetail extends StatelessWidget {
  final String? stationId;

  const StationDetail({super.key, this.stationId});

  @override
  Widget build(BuildContext context) {
    final stationState = context.read<StationState>();
    final subscriptionState = context.read<SubscriptionState>();

    return ChangeNotifierProvider(
      create: (_) => StationViewModel(
        stationState: stationState,
        subscriptionState: subscriptionState,
      )..loadStationDetail(stationId: stationId),
      child: const StationContent(),
    );
  }
}
