import 'package:flutter/material.dart';

import '../constant.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List _dropdownValue = ['User', 'Admin', 'Doctor'];
  Object? _iniialValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: kDefualtColorMain,
      minimumSize: Size(size.width, 50),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  color: kDefualtColorMain,
                ),
                child: Image.asset(
                  'assets/image/logo-petcare-white.png',
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kDefualtPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'John Doe',
                          ),
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'example@hotmail.com',
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: '*************',
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Types',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton(
                          value: _iniialValue,
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefualtPadding / 2),
                            child: Text('Select type user'),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _iniialValue = value;
                              // print(_iniialValue);
                            });
                          },
                          items: _dropdownValue.map(
                            (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signin');
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: kDefualtColorMain,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
