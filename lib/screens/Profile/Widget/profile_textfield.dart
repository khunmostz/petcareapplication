import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final bool readOnly;
  final bool obscureText;
  final TextEditingController? controller;

  const ProfileTextField({
    this.obscureText = false,
    required this.hintText,
    this.readOnly = false,
    this.maxLines = 1,
    this.controller,
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
        maxLines: maxLines,
        readOnly: readOnly,
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
      ),
      );}
}