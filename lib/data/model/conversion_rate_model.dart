class ConversionRateModel {
  final String baseCode;
  final String targetCode;
  final String amount;

  ConversionRateModel(
      {required this.baseCode, required this.targetCode, required this.amount});
}

class ConversionRateResponseModel {
  ConversionRateResponseModel({
    required this.result,
    required this.baseCode,
    required this.targetCode,
    required this.conversionRate,
    required this.conversionResult,
  });

  final String? result;
  final String? baseCode;
  final String? targetCode;
  final double? conversionRate;
  final double? conversionResult;

  factory ConversionRateResponseModel.fromJson(Map<String, dynamic> json) {
    return ConversionRateResponseModel(
      result: json["result"],
      baseCode: json["base_code"],
      targetCode: json["target_code"],
      conversionRate: json["conversion_rate"],
      conversionResult: json["conversion_result"],
    );
  }
}
