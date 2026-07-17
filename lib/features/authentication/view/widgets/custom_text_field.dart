
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController ctr;
  final String hintText;
  final IconData icon;
  final bool obscure;

  const CustomTextField({
    super.key,
    required this.ctr,
    required this.hintText,
    required this.icon,
    required this.obscure,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctr,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
    );
  }
}
