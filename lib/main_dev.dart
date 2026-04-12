import 'package:khmerbike/main_common.dart';
import 'package:provider/provider.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    Provider(create: (_) => null), // Add your dev-specific providers here
  ];
}

void main() {
  mainCommon(devProviders);
}
