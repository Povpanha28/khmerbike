import 'package:khmerbike/data/repository/bike_pass/bike_pass_repository.dart';
import 'package:khmerbike/models/bike_pass.dart';

class BikePassRepositoryMock implements BikePassRepository {
  @override
  Future<List<BikePass>> getBikePass() async {
    // Mock implementation, returning a list of dummy BikePasses
    return [
      BikePass(
        id: '1',
        type: PassType.daily,
        name: 'Daily Pass',
        description: 'Access for 24 hours',
        duration: Duration(days: 1),
        price: 5.0,
      ),
      BikePass(
        id: '2',
        type: PassType.monthly,
        name: 'Monthly Pass',
        description: 'Access for 30 days',
        duration: Duration(days: 30),
        price: 20.0,
      ),
      BikePass(
        id: '3',
        type: PassType.annual,
        name: 'Annual Pass',
        description: 'Access for 365 days',
        duration: Duration(days: 365),
        price: 100.0,
      ),
      BikePass(
        id: '4',
        type: PassType.oneTime,
        name: 'One-Time Pass',
        description: 'Single use access',
        duration: Duration(hours: 1),
        price: 2.0,
      ),
    ];
  }
}
