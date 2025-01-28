import 'package:expense_tracker/data/model/conversion_rate_model.dart';
import 'package:expense_tracker/data/repository/exchange_rate_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_converter_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late ExchangeRateRepository repository;

  setUp(() {
    client = MockClient();
    repository = ExchangeRateRepository(client);
  });

  const jsonString = """{
    "result": "success",
    "documentation": "https://www.exchangerate-api.com/docs",
    "terms_of_use": "https://www.exchangerate-api.com/terms",
    "time_last_update_unix": 1738022401,
    "time_last_update_utc": "Tue, 28 Jan 2025 00:00:01 +0000",
    "time_next_update_unix": 1738108801,
    "time_next_update_utc": "Wed, 29 Jan 2025 00:00:01 +0000",
    "base_code": "USD",
    "target_code": "NGN",
    "conversion_rate": 1531.5671,
    "conversion_result": 3063.1342
  }""";
  final model = ConversionRateModel(
    baseCode: "USD",
    targetCode: "NGN",
    amount: "100",
  );
  final uri = Uri.parse(
      "https://v6.exchangerate-api.com/v6/5c271dd8c490a13d0ce479cc/pair/USD/NGN/100");

  group('Convert Currency', () {
    test('Converts currency successfully', () async {
      // arrange
      when(client.get(uri))
          .thenAnswer((_) async => http.Response(jsonString, 200));

      // act
      final result = await repository.convertCurrency(model);
      print(result);

      // assert
      expect(result.conversionResult, equals(3063.1342));
      verify(client.get(uri));
    });
  });
}
