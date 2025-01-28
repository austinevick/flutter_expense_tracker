import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/screen/home/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

class MockExpense extends Mock implements HomeViewModel {}

class MockHiveBox extends Mock implements Box {}

void main() {
  late final MockExpense mockExpense;


  setUpAll(() {
    mockExpense = MockExpense();
  });


  group("Expense", () {

    test("Add Expense", () async {

      when(mockExpense.box.values.length).thenAnswer((_)  => 1);

      final result = mockExpense.box.values.length > 1;
      expect(result, true);
    });
  });
}
