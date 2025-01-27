import 'dart:convert';

import 'package:http/http.dart';

import '../dataSource/local_data_source.dart';
import '../model/conversion_rate_model.dart';
import '../model/exchange_rate_model.dart';

class ExchangeRateRepository {
  final Client client;

  ExchangeRateRepository(this.client);

  final String _url =
      "https://v6.exchangerate-api.com/v6/5c271dd8c490a13d0ce479cc/";

  Future<ExchangeRateResponseModel> getExchangeRate(String baseCurrency) async {
    final cachedData = await LocalDataSource.getData("exchangeRate");
    if (cachedData == null) {
      final response = await client.get(Uri.parse("${_url}latest/$baseCurrency"));
      final json = jsonDecode(response.body);
      print(json);
      final data = ExchangeRateResponseModel.fromJson(json);
      await LocalDataSource.saveData("exchangeRate", data, 60);
      return data;
    } else {
      return cachedData as ExchangeRateResponseModel;
    }
  }

  Future<ConversionRateResponseModel> convertCurrency(
      ConversionRateModel model) async {
    final response = await client.get(Uri.parse(
        "${_url}pair/${model.baseCode}/${model.targetCode}/${model.amount}"));
    final json = jsonDecode(response.body);
    print(json);
    return ConversionRateResponseModel.fromJson(json);
  }
}
