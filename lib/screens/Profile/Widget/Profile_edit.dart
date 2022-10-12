import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final TextInputType keyboardType;
  final bool readOnly;
  final Color? color;
  final TextEditingController? controller;
  const ProfileEdit({
    Key? key,
    this.maxLines = 1,
    required this.hintText,
    this.controller,
    required this.keyboardType,
    required this.readOnly,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: color,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
