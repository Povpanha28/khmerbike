import 'package:khmerbike/models/bike.dart';
import 'package:khmerbike/models/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStations();
  Future<void> updateStationBikes(String stationId, List<Bike> bikes);
}
