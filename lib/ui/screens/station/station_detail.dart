import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';
import 'package:khmerbike/ui/screens/station/widgets/station_content.dart';
import 'package:khmerbike/ui/states/subscription_state.dart';
import 'package:provider/provider.dart';

class StationDetail extends StatelessWidget {
  final String? stationId;

  const StationDetail({super.key, this.stationId});

  @override
  Widget build(BuildContext context) {
    final stationRepository = context.read<StationRepository>();
    final subscriptionState = context.read<SubscriptionState>();

    return ChangeNotifierProvider(
      create: (_) =>
          StationViewModel(
            repository: stationRepository,
            subscriptionState: subscriptionState,
          )
            ..loadStationDetail(stationId: stationId),
      child: const StationContent(),
    );
  }
}
