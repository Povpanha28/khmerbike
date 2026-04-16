import 'package:flutter/material.dart';
import 'package:khmerbike/data/repository/station/station_repository_firebase.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository_firebase.dart';
import 'package:khmerbike/ui/screens/station/view_model/station_view_model.dart';
import 'package:khmerbike/ui/screens/station/widgets/station_content.dart';
import 'package:khmerbike/ui/states/subscription_state.dart';
import 'package:provider/provider.dart';

class StationDetail extends StatelessWidget {
  final String? stationId;

  const StationDetail({super.key, this.stationId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          StationViewModel(repository: StationRepositoryFirebase(), subscriptionState: SubscriptionState(subscriptionRepo: SubscriptionRepositoryFirebase()))
            ..loadStationDetail(stationId: stationId),
      child: StationContent(),
    );
  }
}
