import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black45,
        ),
        hintText: 'Search',
        border: InputBorder.none,
      ),
    );
  }
}
