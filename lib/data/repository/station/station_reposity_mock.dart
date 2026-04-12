import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/location.dart';
import 'package:khmerbike/models/station.dart';

class StationRepositoryMock implements StationRepository {
  @override
  Future<List<Station>> getStations() async {
    return [
      Station(
        id: '1',
        name: 'Station A',
        location: Location(latitude: 10.0, longitude: 10.0, name: 'Location A'),
        docks: [
          Dock(
            id: 'A1',
            bike: Bike(id: '1', status: BikeStatus.available),
          ),
          Dock(
            id: 'A2',
            bike: Bike(id: '2', status: BikeStatus.inUse),
          ),
          Dock(
            id: 'A3',
            bike: Bike(id: '3', status: BikeStatus.maintenance),
          ),
        ],
      ),
      Station(
        id: '2',
        name: 'Station B',
        location: Location(latitude: 20.0, longitude: 20.0, name: 'Location B'),
        docks: [
          Dock(
            id: 'B1',
            bike: Bike(id: '4', status: BikeStatus.available),
          ),
          Dock(
            id: 'B2',
            bike: Bike(id: '5', status: BikeStatus.inUse),
          ),
          Dock(
            id: 'B3',
            bike: Bike(id: '6', status: BikeStatus.maintenance),
          ),
        ],
      ),
    ];
  }

  @override
  Future<void> updateStationBikes(String stationId, List<Bike> bikes) async {
    // Mock implementation, no actual update logic
    print('Updated station $stationId with bikes $bikes');
  }
}
