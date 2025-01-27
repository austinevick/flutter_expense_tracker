import 'package:expense_tracker/common/Utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data/model/expense_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final box = Hive.box<ExpenseModel>(expenseBox);

  double getTotalExpenses() => box.values.isEmpty
      ? 0
      : box.values
          .map((e) => e.amount)
          .reduce((value, element) => value + element);

  Future<int> addExpense(ExpenseModel expense) async {
    try {
      setLoadingState(true);
     final result= await box.add(expense);
      setLoadingState(false);
      return result;
    } catch (e) {
      setLoadingState(false);
      rethrow;
    }
  }

  Future<void> deleteExpense(int index) async {
    try {
      await box.deleteAt(index);
    } catch (e) {
      print(e);
    }
  }
}
