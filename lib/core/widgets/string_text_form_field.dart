import 'package:flutter/material.dart';

class StringTextFormField extends StatelessWidget {
  const StringTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String? labelText;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textCapitalization: TextCapitalization.words,
      textInputAction: textInputAction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tolong diisi';
        }
        return null;
      },
    );
  }
}
