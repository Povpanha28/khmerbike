import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khmerbike/data/dtos/bike_pass_dto.dart';
import 'package:khmerbike/data/repository/bike_pass/bike_pass_repository.dart';
import 'package:khmerbike/models/bike_pass.dart';

class BikePassRepositoryFirebase implements BikePassRepository {
  List<BikePass>? _cachedBikePasses;

  final Uri bikePassesUri = Uri.https(
    'project-flutter-da783-default-rtdb.firebaseio.com',
    '/bike_passes.json',
  );

  Future<Map<String, dynamic>> _fetchBikePassesJson() async {
    final http.Response response = await http.get(bikePassesUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load bike passes');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <String, dynamic>{};
    }

    return decoded as Map<String, dynamic>;
  }

  @override
  Future<List<BikePass>> getBikePass() async {
    if (_cachedBikePasses != null) {
      return _cachedBikePasses!;
    }

    final Map<String, dynamic> bikePassJson = await _fetchBikePassesJson();

    final List<BikePass> result = [];
    for (final entry in bikePassJson.entries) {
      result.add(BikePassDto.fromJson(entry.key, Map<String, dynamic>.from(entry.value)));
    }

    _cachedBikePasses = result;
    return result;
  }
}
