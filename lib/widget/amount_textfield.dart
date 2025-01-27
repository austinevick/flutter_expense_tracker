import 'package:flutter/material.dart';

import '../common/input_formatters.dart';
import 'custom_text.dart';

class AmountTextField extends StatelessWidget {
  final TextEditingController amount;
  const AmountTextField({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
           CustomText('₦',fontSize: 30,
              fontWeight: FontWeight.w700,
              paddingRight: 4, color: Colors.white),

          Expanded(
            child: TextFormField(
                cursorColor: Colors.white,
                controller: amount,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CustomRangeTextInputFormatter(
                      min: 1, max: 100000),
                ],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 30),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white54),
                )),
          ),
        ],
      ),
    );
  }
}
