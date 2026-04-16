import 'package:khmerbike/data/repository/bike_pass/bike_pass_repository.dart';
import 'package:khmerbike/models/bike_pass.dart';

class BikePassRepositoryMock implements BikePassRepository {
  @override
  Future<List<BikePass>> getBikePass() async {
    // Mock implementation, returning a list of dummy bike passes
    return [
      BikePass(
        id: 'daily',
        passType: PassType.daily,
        name: 'Day pass',
        description: 'First 60 min free per ride\nPlease use within 24 hours',
        validityDays: 1,
        price: 1.99,
        tag: 'Subscribe & Save',
      ),
      BikePass(
        id: 'monthly',
        passType: PassType.monthly,
        name: 'Monthly pass',
        description: 'First 60 min free per ride\nPlease use within 30 days',
        validityDays: 30,
        price: 19.99,
        tag: 'Most Popular',
      ),
      BikePass(
        id: 'annual',
        passType: PassType.annual,
        name: 'Annual pass',
        description: 'First 60 min free per ride\nPlease use within 365 days',
        validityDays: 365,
        price: 59.99,
        tag: 'Best Value',
      ),
    ];
  }
}
