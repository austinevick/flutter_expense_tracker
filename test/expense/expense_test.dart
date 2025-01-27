import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/screen/home/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

class MockExpense extends Mock implements HomeViewModel {}

class MockHiveBox extends Mock implements Box {}

void main() {
  late final MockExpense mockExpense;
  late final MockHiveBox mockHiveBox;

  setUpAll(() {
    mockExpense = MockExpense();
    mockHiveBox = MockHiveBox();
  });

  group("Expense", () {
    test("Add Expense", () async {

      final expense = ExpenseModel(
        date: DateTime.now(),
        description: "Test",
        amount: 100,
        category: "Test",
      );
      when(mockExpense.addExpense(expense)).thenAnswer((_) async => 1);

      final result = await mockExpense.addExpense(expense);
      expect(result, 1);
    });
  });
}
