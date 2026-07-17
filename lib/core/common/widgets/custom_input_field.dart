import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;
  final int? maxLines;


  const CustomInputField({super.key,
  required this.controller,
  required this.label,
  required this.keyBoardType,
    this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyBoardType,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
       labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
    );
  }
}
