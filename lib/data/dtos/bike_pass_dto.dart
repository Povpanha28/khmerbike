import 'package:khmerbike/models/bike_pass.dart';

class BikePassDto {
  static const String passTypeKey = 'passType';
  static const String nameKey = 'name';
  static const String descriptionKey = 'description';
  static const String priceKey = 'price';
  static const String tagKey = 'tag';
  static const String durationDaysKey = 'durationDays';

  static BikePass fromJson(String id, Map<String, dynamic> json) {
    assert(json[passTypeKey] is String);
    assert(json[nameKey] is String);
    assert(json[descriptionKey] is String);
    assert(json[priceKey] is num);
    assert(json[tagKey] is String);
    assert(json[durationDaysKey] is int);

    return BikePass(
      id: id,
      passType: _passTypeFromString(json[passTypeKey] as String),
      name: json[nameKey] as String,
      description: json[descriptionKey] as String,
      price: (json[priceKey] as num).toDouble(),
      tag: json[tagKey] as String,
      validityDays: json[durationDaysKey] as int,
    );
  }

  static Map<String, dynamic> toJson(BikePass bikePass) {
    return {
      passTypeKey: _passTypeToString(bikePass.passType),
      nameKey: bikePass.name,
      descriptionKey: bikePass.description,
      priceKey: bikePass.price,
      tagKey: bikePass.tag,
      durationDaysKey: bikePass.validityDays,
    };
  }

  static PassType _passTypeFromString(String value) {
    switch (value) {
      case 'daily':
        return PassType.daily;
      case 'monthly':
        return PassType.monthly;
      case 'annual':
        return PassType.annual;
      case 'oneTime':
        return PassType.oneTime;
      default:
        throw ArgumentError('Unknown pass type: $value');
    }
  }

  static String _passTypeToString(PassType passType) {
    switch (passType) {
      case PassType.monthly:
        return 'monthly';
      case PassType.daily:
        return 'daily';
      case PassType.annual:
        return 'annual';
      case PassType.oneTime:
        return 'oneTime';
    }
  }
}
