import 'dart:math';

import 'package:khmerbike/data/repository/station/station_repository.dart';
import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/dock.dart';
import 'package:khmerbike/models/location.dart';
import 'package:khmerbike/models/station.dart';

class StationRepositoryMock implements StationRepository {
  final Random _random = Random();

  // Generate realistic bike status distribution
  BikeStatus _getRandomStatus() {
    int r = _random.nextInt(100);
    if (r < 60) return BikeStatus.available;     // 60%
    if (r < 85) return BikeStatus.inUse;         // 25%
    return BikeStatus.maintenance;               // 15%
  }

  // Generate random docks
  List<Dock> _generateRandomDocks(int count) {
    return List.generate(count, (index) {
      final hasBike = _random.nextBool();

      return Dock(
        id: 'D${index + 1}',
        bike: hasBike
            ? Bike(
                id: '${_random.nextInt(1000)}',
                status: _getRandomStatus(),
              )
            : null,
      );
    });
  }

  @override
  Future<List<Station>> getStations() async {
    return [
      // ===== EXISTING STATIONS =====
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
          //more available docks
          Dock(
            id: 'A4',
            bike: Bike(id: '7', status: BikeStatus.available),
          ),
          Dock(
            id: 'A5',
            bike: Bike(id: '8', status: BikeStatus.available),
          ),    
        ],
      ),
      Station(
        id: '2',
        name: 'Station B',
        location: Location(
          latitude: 11.5553,
          longitude: 104.9283,
          name: 'Location B',
        ),
        docks: _generateRandomDocks(4 + _random.nextInt(6)),
      ),
      Station(
        id: '3',
        name: 'Station C',
        location: Location(
          latitude: 11.5650,
          longitude: 104.9300,
          name: 'Location C',
        ),
        docks: _generateRandomDocks(4 + _random.nextInt(6)),
      ),

      // ===== PHNOM PENH LANDMARKS =====
      Station(
        id: '4',
        name: 'Independence Monument',
        location: Location(
          latitude: 11.5621,
          longitude: 104.9165,
          name: 'Independence Monument',
        ),
        docks: _generateRandomDocks(6 + _random.nextInt(5)),
      ),
      Station(
        id: '5',
        name: 'Wat Phnom',
        location: Location(
          latitude: 11.5735,
          longitude: 104.9248,
          name: 'Wat Phnom',
        ),
        docks: _generateRandomDocks(5 + _random.nextInt(6)),
      ),
      Station(
        id: '6',
        name: 'Royal Palace',
        location: Location(
          latitude: 11.5562,
          longitude: 104.9287,
          name: 'Royal Palace',
        ),
        docks: _generateRandomDocks(6 + _random.nextInt(5)),
      ),
      Station(
        id: '7',
        name: 'Tuol Sleng',
        location: Location(
          latitude: 11.5489,
          longitude: 104.9214,
          name: 'Tuol Sleng',
        ),
        docks: _generateRandomDocks(4 + _random.nextInt(6)),
      ),
      Station(
        id: '8',
        name: 'Aeon Mall Phnom Penh',
        location: Location(
          latitude: 11.5405,
          longitude: 104.9302,
          name: 'Aeon Mall Phnom Penh',
        ),
        docks: _generateRandomDocks(6 + _random.nextInt(5)),
      ),
      Station(
        id: '9',
        name: 'Olympic Stadium',
        location: Location(
          latitude: 11.5672,
          longitude: 104.9003,
          name: 'Olympic Stadium',
        ),
        docks: _generateRandomDocks(5 + _random.nextInt(6)),
      ),
      Station(
        id: '10',
        name: 'Riverside',
        location: Location(
          latitude: 11.5568,
          longitude: 104.9350,
          name: 'Riverside',
        ),
        docks: _generateRandomDocks(6 + _random.nextInt(5)),
      ),
      Station(
        id: '11',
        name: 'TK Avenue',
        location: Location(
          latitude: 11.5708,
          longitude: 104.8895,
          name: 'TK Avenue',
        ),
        docks: _generateRandomDocks(4 + _random.nextInt(6)),
      ),
      Station(
        id: '12',
        name: 'Russian Market',
        location: Location(
          latitude: 11.5515,
          longitude: 104.9172,
          name: 'Russian Market',
        ),
        docks: _generateRandomDocks(5 + _random.nextInt(6)),
      ),
      Station(
        id: '13',
        name: 'Night Market',
        location: Location(
          latitude: 11.5633,
          longitude: 104.9315,
          name: 'Night Market',
        ),
        docks: _generateRandomDocks(6 + _random.nextInt(5)),
      ),

      // ===== EXTRA STATIONS =====
      Station(
        id: '14',
        name: 'Central Market',
        location: Location(
          latitude: 11.5564,
          longitude: 104.9230,
          name: 'Central Market',
        ),
        docks: _generateRandomDocks(5 + _random.nextInt(6)),
      ),
      Station(
        id: '15',
        name: 'Wat Ounalom',
        location: Location(
          latitude: 11.5696,
          longitude: 104.9210,
          name: 'Wat Ounalom',
        ),
        docks: _generateRandomDocks(4 + _random.nextInt(7)),
      ),
      Station(
        id: '16',
        name: 'Diamond Island',
        location: Location(
          latitude: 11.5480,
          longitude: 104.9405,
          name: 'Diamond Island',
        ),
        docks: _generateRandomDocks(6 + _random.nextInt(5)),
      ),
      Station(
        id: '17',
        name: 'NagaWorld',
        location: Location(
          latitude: 11.5595,
          longitude: 104.9372,
          name: 'NagaWorld',
        ),
        docks: _generateRandomDocks(5 + _random.nextInt(6)),
      ),
      Station(
        id: '18',
        name: 'Chroy Changvar',
        location: Location(
          latitude: 11.5752,
          longitude: 104.9340,
          name: 'Chroy Changvar',
        ),
        docks: _generateRandomDocks(4 + _random.nextInt(6)),
      ),
      Station(
        id: '19',
        name: 'Tuol Tom Poung',
        location: Location(
          latitude: 11.5320,
          longitude: 104.9178,
          name: 'Tuol Tom Poung',
        ),
        docks: _generateRandomDocks(4 + _random.nextInt(6)),
      ),
      Station(
        id: '20',
        name: 'Olympic Market',
        location: Location(
          latitude: 11.5610,
          longitude: 104.9055,
          name: 'Olympic Market',
        ),
        docks: _generateRandomDocks(5 + _random.nextInt(5)),
      ),
    ];
  }

  @override
  Future<void> updateStationBikes(String stationId, List<Bike> bikes) async {
    print('Updated station $stationId with bikes $bikes');
  }
}