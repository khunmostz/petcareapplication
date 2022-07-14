import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordDialog extends StatelessWidget {
  final String title;
  final String hinText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const RecordDialog({
    Key? key,
    required this.title,
    required this.hinText,
    required this.controller,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.mitr(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            // obscureText: obscureText,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: hinText,
            ),
          ),
        )
      ],
    );
  }
}
