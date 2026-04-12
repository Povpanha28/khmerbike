import 'package:khmerbike/data/repository/bike/bike_repository.dart';
import 'package:khmerbike/models/bike.dart';

class BikeRepositoryMock implements BikeRepository {
  @override
  Future<List<Bike>> getBikes() async {
    return [
      Bike(id: '1', status: BikeStatus.available),
      Bike(id: '2', status: BikeStatus.inUse),
      Bike(id: '3', status: BikeStatus.maintenance),
    ];
  }

  @override
  Future<void> updateBikeStatus(String bikeId, BikeStatus status) async {
    // Mock implementation, no actual update logic
    print('Updated bike $bikeId to status $status');
  }
}
