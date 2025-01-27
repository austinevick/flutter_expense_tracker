import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

const String expenseBox = 'expenses';
const String currencyBox = 'currency';

const String naira = "₦";

void simpleNotification(String msg, bool isError) {
  HapticFeedback.vibrate();
  showSimpleNotification(Text(msg),
      leading: const Icon(Icons.info_outline),
      background: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 5));
}

String formatDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

String formatAmount(double amount) {
  final formatter = NumberFormat("#,###,###,###");
  return naira + formatter.format(amount);
}

String formatNumber(double amount) {
  final formatter = NumberFormat("#,###,###,###");
  return formatter.format(amount);
}
