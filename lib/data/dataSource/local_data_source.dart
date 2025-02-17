import 'package:expense_tracker/common/Utils.dart';
import 'package:hive/hive.dart';

import '../model/exchange_rate_model.dart';

class LocalDataSource {
  static final box = Hive.box<ExchangeRateResponseModel>(currencyBox);

  static Future<void> saveData(
      String key, ExchangeRateResponseModel data, int expiryInMinutes) async {
    final expiryTime = DateTime.now()
        .add(Duration(minutes: expiryInMinutes))
        .millisecondsSinceEpoch;
    data.expiration = expiryTime;
    await box.put(key, data);
  }

  static Future<dynamic> getData(String key) async {
    final data = box.get(key);
    if (data != null) {
      if (data.expiration! > DateTime.now().millisecondsSinceEpoch) {
        print(data.timeNextUpdateUtc);
        return data;
      } else {
        await box.delete(key);
      }
    }
    return null;
  }
}
