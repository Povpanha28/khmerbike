import 'package:khmerbike/data/repository/bike_pass/bike_pass_repository.dart';
import 'package:khmerbike/data/repository/bike_pass/bike_pass_repository_firebase.dart';
import 'package:khmerbike/data/repository/station/station_repository_firebase.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository_firebase.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/main_common.dart';
import 'package:khmerbike/ui/states/subscription_state.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:khmerbike/ui/states/station_state.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    Provider<BikePassRepository>(create: (_) => BikePassRepositoryFirebase()),
    Provider<SubscriptionRepository>(
      create: (_) => SubscriptionRepositoryFirebase(),
    ),
    Provider<StationRepository>(
      create: (context) => StationRepositoryFirebase(),
    ),
    ChangeNotifierProvider<StationState>(
      create: (context) =>
          StationState(repository: context.read<StationRepository>()),
    ),
    ChangeNotifierProvider<SubscriptionState>(
      create: (context) => SubscriptionState(
        subscriptionRepo: context.read<SubscriptionRepository>(),
      ),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
