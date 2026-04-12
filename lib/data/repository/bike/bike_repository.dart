import 'package:khmerbike/models/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> getBikes();
  Future<void> updateBikeStatus(String bikeId, BikeStatus status);
}
