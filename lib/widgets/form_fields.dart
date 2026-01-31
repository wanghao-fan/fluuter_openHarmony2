import 'package:flutter/material.dart';
import 'validators.dart';

class CustomFormField {
  final String name;
  final String label;
  final bool obscure;
  final TextInputType keyboardType;
  final Validator? validator;
  final String? initialValue;

  CustomFormField({
    required this.name,
    required this.label,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.initialValue,
  });
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType keyboardType;
  final Validator? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        validator: validator,
      ),
    );
  }
}
