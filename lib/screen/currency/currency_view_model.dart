import 'package:expense_tracker/common/Utils.dart';
import 'package:expense_tracker/screen/currency/currency_list_screen.dart';
import 'package:flutter/foundation.dart';

import '../../data/model/conversion_rate_model.dart';
import '../../data/model/exchange_rate_model.dart';
import '../../data/repository/exchange_rate_repository.dart';

class CurrencyViewModel extends ChangeNotifier {
  final ExchangeRateRepository repository;

  CurrencyViewModel(this.repository);

  void refreshProvider() {
    notifyListeners();
  }

  ConversionRateResponseModel? conversionRate;

  Currency fromCurrency = Currency('USD', 1);
  Currency toCurrency = Currency('USD', 1);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setFromCurrency(Currency currency) {
    fromCurrency = currency;
    notifyListeners();
  }

  void setToCurrency(Currency currency) {
    toCurrency = currency;
    notifyListeners();
  }

  void flipCurrency() {
    final temp = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = temp;
    notifyListeners();
  }

  double formatAmount(String amount) {
    if (amount.isEmpty) {
      return fromCurrency.rate.toDouble();
    }
    return double.parse(amount);
  }

  Future<ExchangeRateResponseModel> getExchangeRate(String code) async {
    try {
      final response = await repository.getExchangeRate(code);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ConversionRateResponseModel> convertCurrency(
      ConversionRateModel model) async {
    try {
      setLoadingState(true);
      final response = await repository.convertCurrency(model);
      if (response.result == "success") {
        conversionRate = response;
        notifyListeners();
        setLoadingState(false);
        return response;
      } else {
        setLoadingState(false);
        simpleNotification("Something went wrong", true);
      }
      setLoadingState(false);
      return response;
    } catch (e) {
      setLoadingState(false);
      simpleNotification('Something went wrong', true);
      rethrow;
    }
  }
}
