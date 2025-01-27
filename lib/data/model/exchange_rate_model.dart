import 'package:hive/hive.dart';

part 'exchange_rate_model.g.dart';

@HiveType(typeId: 1)
class ExchangeRateResponseModel {
  ExchangeRateResponseModel({
    required this.result,
    required this.documentation,
    required this.termsOfUse,
    required this.timeLastUpdateUnix,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUnix,
    required this.timeNextUpdateUtc,
    required this.baseCode,
    required this.conversionRates,
    this.expiration,
  });

  @HiveField(0)
  final String? result;
  @HiveField(1)
  final String? documentation;
  @HiveField(2)
  final String? termsOfUse;
  @HiveField(3)
  final num? timeLastUpdateUnix;
  @HiveField(4)
  final String? timeLastUpdateUtc;
  @HiveField(5)
  final num? timeNextUpdateUnix;
  @HiveField(6)
  final String? timeNextUpdateUtc;
  @HiveField(7)
  final String? baseCode;
  @HiveField(8)
  final Map<String, num> conversionRates;
  @HiveField(9)
  int? expiration;

  set setExpiration(int value) {
    expiration = value;
  }

  int? get getExpiration => expiration;

  factory ExchangeRateResponseModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRateResponseModel(
      result: json["result"],
      documentation: json["documentation"],
      termsOfUse: json["terms_of_use"],
      timeLastUpdateUnix: json["time_last_update_unix"],
      timeLastUpdateUtc: json["time_last_update_utc"],
      timeNextUpdateUnix: json["time_next_update_unix"],
      timeNextUpdateUtc: json["time_next_update_utc"],
      baseCode: json["base_code"],
      conversionRates: Map.from(json["conversion_rates"])
          .map((k, v) => MapEntry<String, num>(k, v)),
    );
  }
}
