import 'package:expense_tracker/data/repository/exchange_rate_repository.dart';
import 'package:expense_tracker/screen/home/home_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../screen/auth/auth_view_model.dart';
import '../screen/currency/currency_view_model.dart';

final getIt = GetIt.instance;

void registerSingleton() {
  getIt.registerSingleton<AuthViewModel>(AuthViewModel(FirebaseAuth.instance));
  getIt.registerSingleton<HomeViewModel>(HomeViewModel());
  getIt.registerSingleton<ExchangeRateRepository>(ExchangeRateRepository(Client()));
  getIt.registerSingleton<CurrencyViewModel>(CurrencyViewModel(getIt<ExchangeRateRepository>()));
}
