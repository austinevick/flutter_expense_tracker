import 'dart:math';

import 'package:expense_tracker/common/Utils.dart';
import 'package:expense_tracker/common/app_colors.dart';
import 'package:expense_tracker/data/model/conversion_rate_model.dart';
import 'package:expense_tracker/widget/currency_card.dart';
import 'package:expense_tracker/widget/custom_text.dart';
import 'package:expense_tracker/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_button.dart';
import 'currency_view_model.dart';

class CurrencyListScreen extends StatefulWidget {
  const CurrencyListScreen({super.key});

  @override
  State<CurrencyListScreen> createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  final amountController = TextEditingController();

  @override
  void initState() {
    final provider = Provider.of<CurrencyViewModel>(context, listen: false);
    provider.getExchangeRate("USD");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Currency Converter'),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CurrencyCard(
                      onCurrencyChange: () async {
                        final result = await showModalBottomSheet<Currency>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) {
                              return CurrencyModal();
                            });
                        viewModel.setFromCurrency(result!);
                        viewModel.getExchangeRate(viewModel.fromCurrency.code);
                      },
                      leadingText: 'From',
                      currency: viewModel.fromCurrency),
                  const SizedBox(height: 16),
                  GestureDetector(
                      onTap: () => viewModel.flipCurrency(),
                      child: Image.asset('images/exchange.png')),
                  const SizedBox(height: 16),
                  CurrencyCard(
                      onCurrencyChange: () async {
                        final result = await showModalBottomSheet<Currency>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) => CurrencyModal());
                        viewModel.setToCurrency(result!);
                        viewModel.getExchangeRate(viewModel.toCurrency.code);
                      },
                      leadingText: 'To',
                      currency: viewModel.toCurrency),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    textStyle:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    hintText: 'Enter amount',
                    hintStyle: TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  viewModel.conversionRate != null
                      ? CustomText(
                          '${formatNumber(viewModel.formatAmount(amountController.text))} ${viewModel.conversionRate!.baseCode} = ${formatNumber(viewModel.conversionRate!.conversionResult ?? 0)} ${viewModel.conversionRate!.targetCode}',
                          textAlign: TextAlign.center,
                        )
                      : CustomText(
                          '${viewModel.fromCurrency.rate} ${viewModel.fromCurrency.code} = ${viewModel.toCurrency.rate} ${viewModel.toCurrency.code}'),
                  const SizedBox(height: 20),
                  CustomButton(
                    isLoading: viewModel.isLoading,
                    onPressed: () {
                      if (amountController.text.isEmpty) {
                        simpleNotification('Please enter amount', true);
                        return;
                      }
                      final model = ConversionRateModel(
                          baseCode: viewModel.fromCurrency.code,
                          targetCode: viewModel.toCurrency.code,
                          amount: amountController.text.trim());
                      viewModel.convertCurrency(model);
                    },
                    height: 50,
                    color: primaryColor,
                    child: ButtonLoader(
                        isLoading: viewModel.isLoading, text: "Convert"),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ));
    });
  }
}

class CurrencyModal extends StatelessWidget {
  const CurrencyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyViewModel>(builder: (context, viewModel, child) {
      return Padding(
        padding: EdgeInsets.only(top: 25),
        child: FutureBuilder(
            future: viewModel.getExchangeRate("USD"),
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      CustomText('Something went wrong',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          paddingTop: 30,
                          paddingBottom: 16),
                      CustomButton(
                          height: 50,
                          onPressed: () => viewModel.refreshProvider(),
                          child:
                              CustomText('Retry', fontWeight: FontWeight.w700))
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.conversionRates.length,
                    itemBuilder: (context, index) {
                      final currency =
                          snapshot.data!.conversionRates.keys.elementAt(index);
                      final rate = snapshot.data!.conversionRates.values
                          .elementAt(index);
                      return ListTile(
                          tileColor: Colors.white,
                          leading: CircleAvatar(
                              backgroundColor: primaryColor,
                              child:
                                  CustomText(currency[0], color: Colors.white)),
                          title: CustomText(currency),
                          onTap: () =>
                              Navigator.pop(context, Currency(currency, rate)));
                    });
              }
              return Center(child: CircularProgressIndicator());
            }),
      );
    });
  }
}

class Currency {
  final String code;
  final num rate;

  Currency(this.code, this.rate);
}
