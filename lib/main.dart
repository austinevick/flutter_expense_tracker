import 'package:expense_tracker/data/model/exchange_rate_model.dart';
import 'package:expense_tracker/screen/auth/auth_view_model.dart';
import 'package:expense_tracker/screen/currency/currency_view_model.dart';
import 'package:expense_tracker/service/getit_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'common/Utils.dart';
import 'data/model/expense_model.dart';
import 'screen/auth/AuthStateNotifier.dart';
import 'screen/home/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(ExchangeRateResponseModelAdapter());
  await Hive.openBox<ExpenseModel>(expenseBox);
  await Hive.openBox<ExchangeRateResponseModel>(currencyBox);
  registerSingleton();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => getIt<AuthViewModel>()),
          ChangeNotifierProvider(create: (ctx) => getIt<HomeViewModel>()),
          ChangeNotifierProvider(create: (ctx) => getIt<CurrencyViewModel>()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(backgroundColor: Colors.white),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: AuthStateNotifier(),
        ),
      ),
    );
  }
}
