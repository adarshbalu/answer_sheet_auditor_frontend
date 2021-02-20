import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    @required this.label,
    @required this.inputType,
    this.textCapitalization = TextCapitalization.words,
    this.initialValue = '',
    this.obscureText = false,
    this.autofocus = false,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.isBorderEnabled = true,
    this.inputFormatters = const [],
  });

  final String label;
  final String initialValue;
  final TextInputType inputType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool autofocus;
  final Function(String) onSaved;
  final Function(String) onChanged;
  final String Function(String) validator;
  final bool isBorderEnabled;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextFormField(
      inputFormatters: inputFormatters,
      style: textTheme.headline1,
      initialValue: initialValue,
      autofocus: autofocus,
      keyboardType: inputType,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textTheme.headline5,
        border: isBorderEnabled
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              )
            : InputBorder.none,
      ),
    );
  }
}
