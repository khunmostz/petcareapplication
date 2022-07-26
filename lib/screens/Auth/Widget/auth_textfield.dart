import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const AuthTextField({
    this.obscureText = false,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.onSaved,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
        validator: validator,
        onSaved: onSaved,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
