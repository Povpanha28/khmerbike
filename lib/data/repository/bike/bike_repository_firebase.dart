import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khmerbike/data/dtos/bike_dto.dart';
import 'package:khmerbike/data/repository/bike/bike_repository.dart';
import 'package:khmerbike/models/bike.dart';

class BikeRepositoryFirebase implements BikeRepository {
  List<Bike>? _cachedBikes;

  final Uri bikesUri = Uri.https(
    'project-flutter-da783-default-rtdb.firebaseio.com',
    '/bikes.json',
  );

  Future<Map<String, dynamic>> _fetchBikesJson() async {
    final http.Response response = await http.get(bikesUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load bikes');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <String, dynamic>{};
    }

    return decoded as Map<String, dynamic>;
  }

  @override
  Future<List<Bike>> getBikes() async {
    if (_cachedBikes != null) {
      return _cachedBikes!;
    }

    final Map<String, dynamic> bikeJson = await _fetchBikesJson();

    final List<Bike> result = [];
    for (final entry in bikeJson.entries) {
      result.add(BikeDto.fromJson(entry.key, Map<String, dynamic>.from(entry.value)));
    }

    _cachedBikes = result;
    return result;
  }

  @override
  Future<void> updateBikeStatus(String bikeId, BikeStatus status) async {
    final Uri bikeUri = Uri.https(
      'project-flutter-da783-default-rtdb.firebaseio.com',
      '/bikes/$bikeId.json',
    );

    final http.Response response = await http.patch(
      bikeUri,
      body: json.encode({BikeDto.statusKey: BikeDto.toJson(Bike(id: bikeId, status: status))[BikeDto.statusKey]}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update bike status');
    }

    if (_cachedBikes != null) {
      _cachedBikes = _cachedBikes!
          .map((bike) => bike.id == bikeId ? Bike(id: bike.id, status: status) : bike)
          .toList();
    }
  }
}
