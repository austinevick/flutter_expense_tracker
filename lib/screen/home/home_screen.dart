import 'package:expense_tracker/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/Utils.dart';
import '../../common/app_colors.dart';
import '../currency/currency_list_screen.dart';
import 'add_expense_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText("Hello, John Doe"),
           actions: [
            IconButton(
            icon: Icon(Icons.currency_exchange),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => CurrencyListScreen())))
          ],
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CustomText("Total Expenses",
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                  )),
                Center(
                  child: CustomText(formatAmount(viewModel.getTotalExpenses()),
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 40),
              if(viewModel.box.values.isNotEmpty)  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText("Recent Transactions",
                        fontSize: 18, fontWeight: FontWeight.w700)),
                ...List.generate(viewModel.box.length, (i) {
                  final expense = viewModel.box.getAt(i);
                  return ListTile(
                    onTap: () => viewModel.deleteExpense(i),
                      contentPadding: EdgeInsets.zero,
                      leading:
                          CircleAvatar(child: CustomText(expense!.category[0])),
                      title: CustomText(expense.category),
                      subtitle: CustomText(expense.description,
                          fontSize: 12, color: Colors.grey),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(formatAmount(expense.amount)),
                          CustomText(formatDate(expense.date),
                              color: Colors.grey),
                        ],
                      ));
                })
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => AddExpenseScreen())),
          child: Icon(Icons.add, color: Colors.white),
        ),
      );
    });
  }
}
