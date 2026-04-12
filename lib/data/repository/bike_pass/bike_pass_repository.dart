import 'package:khmerbike/models/bike_pass.dart';

abstract class BikePassRepository {
  Future<List<BikePass>> getBikePass();
}