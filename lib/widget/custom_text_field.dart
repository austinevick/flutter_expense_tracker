import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Color? fillColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int maxLines;
  final TextAlign? textAlign;
  final bool? autoFocus;
  final int? maxLength;
  final bool? filled;
  final Widget? suffixIcon;
  final bool? hasBorderside;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final Color borderColor;
  final String? initialValue;
  final AutovalidateMode? autovalidateMode;

  const CustomTextfield({
    super.key,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
    this.autoFocus = false,
    this.keyboardType,
    this.autovalidateMode,
    this.textCapitalization = TextCapitalization.words,
    this.onChanged,
    this.maxLines = 1,
    this.filled = true,
    this.hasBorderside = true,
    this.fillColor = Colors.white,
    this.borderColor = primaryColor,
    this.maxLength,
    this.textStyle,
    this.textAlign,
    this.suffixIcon,
    this.autofillHints,
    this.readOnly = false,
    this.initialValue,
    this.onTap,
    this.prefixIcon,
    this.inputFormatters, this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      initialValue: initialValue,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChanged,
      autofocus: autoFocus!,
      autovalidateMode: autovalidateMode,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      readOnly: readOnly!,
      controller: controller,
      cursorWidth: 1.0,
      maxLines: maxLines,
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(13),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: borderColor)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
              borderSide: !hasBorderside!
                  ? BorderSide.none
                  : BorderSide(width: 1, color: borderColor)),
          border: OutlineInputBorder(
              borderSide: !hasBorderside!
                  ? BorderSide.none
                  : const BorderSide(width: 0.5),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: !hasBorderside!
                  ? BorderSide.none
                  : const BorderSide(
                      width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.20)),
              borderRadius: BorderRadius.circular(8)),
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle:hintStyle ?? const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.32), fontSize: 14)),
      style: textStyle ??
          const TextStyle(
              fontSize: 16,
              inherit: false,
              textBaseline: TextBaseline.alphabetic,
              color: Colors.black),
    );
  }
}
