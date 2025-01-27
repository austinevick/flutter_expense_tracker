import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel {
  @HiveField(0)
  final String description;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String category;

  ExpenseModel(
      {required this.description,
      required this.amount,
      required this.date,
      required this.category});

  Map<String, dynamic> toMap() => {
        'description': description,
        'category': category,
        'amount': amount,
        'date': date.toIso8601String(),
      };
}
