import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    this.validator,
    this.onSaved,
  });
  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintStyle: GoogleFonts.mitr(),
      ),
      validator: validator,
      onSaved: onSaved,
      textInputAction: TextInputAction.next,
    );
  }
}
