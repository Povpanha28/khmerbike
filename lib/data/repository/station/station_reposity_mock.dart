import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/location.dart';
import 'package:khmerbike/models/station.dart';

class StationRepositoryMock implements StationRepository {
  @override
  Future<List<Station>> getStations() async {
    return [
      Station(
        id: '1',
        name: 'Station A',
        availableBikes: [
          Bike(id: '1', status: BikeStatus.available),
          Bike(id: '2', status: BikeStatus.inUse),
        ],
        capacity: 10,
        location: Location(latitude: 10.0, longitude: 10.0, name: 'Location A'),
      ),
      Station(
        id: '2',
        name: 'Station B',
        availableBikes: [
          Bike(id: '3', status: BikeStatus.maintenance),
          Bike(id: '4', status: BikeStatus.available),
        ],
        capacity: 15,
        location: Location(latitude: 20.0, longitude: 20.0, name: 'Location B'),
      ),
    ];
  }

  @override
  Future<void> updateStationBikes(String stationId, List<Bike> bikes) async {
    // Mock implementation, no actual update logic
    print('Updated station $stationId with bikes $bikes');
  }
}
