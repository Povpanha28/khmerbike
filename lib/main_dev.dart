import 'package:khmerbike/data/repository/subscription/subscription_repository_mock.dart';
import 'package:khmerbike/data/repository/subscription/subscription_repository.dart';
import 'package:khmerbike/data/repository/station/station_reposity_mock.dart';
import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/main_common.dart';
import 'package:provider/provider.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    Provider<SubscriptionRepository>(
      create: (_) => SubscriptionRepositoryMock(),
    ),
    Provider<StationRepository>(create: (context) => StationRepositoryMock()),
  ];
}

void main() {
  mainCommon(devProviders);
}
