// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/widget/amount_textfield.dart';
import 'package:expense_tracker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_colors.dart';
import '../../data/model/expense_model.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_field.dart';
import 'home_view_model.dart';

class AddExpenseScreen extends StatefulWidget {
  final ExpenseModel? model;
  final int? index;
  const AddExpenseScreen({super.key, this.model, this.index});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  final description = TextEditingController();
  final amount = TextEditingController();
  final date = TextEditingController();
  final category = TextEditingController();

  @override
  void initState() {
    if (widget.model != null) {
      description.text = widget.model!.description;
      amount.text = widget.model!.amount.toString();
      category.text = widget.model!.category;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: CustomText('Add Expense', color: Colors.white),
          actions: [
            if (widget.model != null)
              IconButton(
                  onPressed: () => viewModel
                      .deleteExpense(widget.index!)
                      .whenComplete(() => Navigator.of(context).pop()),
                  icon: Icon(Icons.delete_outline))
          ],
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 250,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText('How much?',
                              fontSize: 18,
                              paddingLeft: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white54),
                        ),
                        AmountTextField(amount: amount)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 16),
                          CustomTextfield(
                              controller: category,
                              hintText: 'Category',
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              suffixIcon:
                                  Icon(Icons.keyboard_arrow_down_outlined),
                              onTap: () async {
                                final result = await showModalBottomSheet<
                                        String>(
                                    backgroundColor: Colors.white,
                                    context: context,
                                    builder: (cxt) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText('Select Category',
                                                fontSize: 18,
                                                paddingTop: 16,
                                                paddingBottom: 8,
                                                fontWeight: FontWeight.w700),
                                            ...List.generate(
                                                categories.length,
                                                (i) => ListTile(
                                                      onTap: () =>
                                                          Navigator.pop(context,
                                                              categories[i]),
                                                      trailing: Icon(Icons
                                                          .keyboard_arrow_right_outlined),
                                                      title: CustomText(
                                                          categories[i]),
                                                    ))
                                          ],
                                        ));
                                setState(() => category.text = result!);
                              },
                              validator: (value) => value!.isEmpty
                                  ? 'Category is required'
                                  : null),
                          SizedBox(height: 16),
                          CustomTextfield(
                              controller: description,
                              hintText: 'Description',
                              keyboardType: TextInputType.text,
                              validator: (value) => value!.isEmpty
                                  ? 'Description is required'
                                  : null),
                          SizedBox(height: 25),
                          CustomButton(
                            height: 50,
                            isLoading: viewModel.isLoading,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final expense = ExpenseModel(
                                    description: description.text,
                                    amount: double.parse(amount.text),
                                    date: DateTime.now(),
                                    category: category.text);

                                Future.delayed(Duration(seconds: 1))
                                    .whenComplete(() {
                                  if (widget.model != null) {
                                    viewModel
                                        .updateExpense(widget.index!, expense)
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                  } else {
                                    viewModel.addExpense(expense).whenComplete(
                                        () => Navigator.pop(context));
                                  }
                                });
                              }
                            },
                            color: primaryColor,
                            child: ButtonLoader(
                                isLoading: viewModel.isLoading,
                                text: 'Add Expense'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

final categories = ['Shopping', 'Subscription', 'Food', 'Travel', 'Other'];
