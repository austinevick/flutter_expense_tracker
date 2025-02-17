import 'package:expense_tracker/screen/home/home_drawer.dart';
import 'package:expense_tracker/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/Utils.dart';
import '../../common/app_colors.dart';
import 'add_expense_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: CustomText("Hello, John Doe"),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: CustomText(
                  "Total Expenses",
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )),
                Center(
                  child: CustomText(formatAmount(viewModel.getTotalExpenses()),
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 40),
                if (viewModel.box.values.isNotEmpty)
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText("Recent Transactions",
                          fontSize: 18, fontWeight: FontWeight.w700)),
                ...List.generate(viewModel.box.length, (i) {
                  final expense = viewModel.box.getAt(i);
                  return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => AddExpenseScreen(
                                    index: i,
                                    model: expense,
                                  ))),
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: CustomText(expense!.category[0],
                              color: Colors.white)),
                      title: CustomText(expense.category),
                      subtitle: CustomText(expense.description,
                          fontSize: 12, color: Colors.grey),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(formatAmount(expense.amount),
                              fontSize: 16, color: Colors.red),
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
