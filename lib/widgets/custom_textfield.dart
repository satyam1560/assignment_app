import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    required this.hint,
    this.validator,
    this.onSaved,
    super.key,
  });

  final String label;
  final String hint;
  final String? Function(String? value)? validator;
  final Function(String? value)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade900,
          ),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade900,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
