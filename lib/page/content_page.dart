import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:petcare_project/constant.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.3,
            decoration: BoxDecoration(
                color: kDefualtColorMain,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )),
            child: Padding(
              padding: const EdgeInsets.all(kDefualtPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 25,
                      ),
                      Spacer(),
                      Icon(
                        Icons.person,
                        size: 25,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hi User',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade50,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black45,
                        ),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
