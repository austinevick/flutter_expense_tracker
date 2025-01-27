import 'package:flutter/services.dart';

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  CustomRangeTextInputFormatter({required this.min, required this.max});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < min) {
      return const TextEditingValue().copyWith(text: min.toStringAsFixed(0));
    } else if (int.parse(newValue.text) > max) {
      return const TextEditingValue();
    } else {
      const TextEditingValue().copyWith(text: max.toString());
    }
    return newValue;
  }
}