import 'package:geocoding/geocoding.dart' as geo;

class GeocodingService {
  Future<geo.Location?> search(String query) async {
    try {
      final result = await geo.locationFromAddress(query);
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      return null;
    }
  }
}