import 'package:expense_tracker/screen/currency/currency_list_screen.dart';
import 'package:flutter/material.dart';

import '../common/Utils.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CurrencyCard extends StatelessWidget {
  final VoidCallback onCurrencyChange;
  final String leadingText;
  final Currency currency;

  const CurrencyCard({super.key, required this.onCurrencyChange,
    required this.leadingText, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xffe3e1e6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(leadingText),
                CustomButton(
                    width: null,
                    height: null,
                    onPressed: onCurrencyChange,
                    child: Row(
                      children: [
                        CustomText(
                          currency.code,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ))
              ],
            ),
            CustomText(currency.code+ currency.rate.toStringAsFixed(2))
          ],
        )));

  }
}
