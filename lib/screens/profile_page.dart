import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/data/petData.dart';
import '../utils/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //ปูพื้น
                Container(
                  width: size.width,
                  height: size.height >= 920
                      ? size.height * 0.32
                      : size.height * 0.45,
                  color: Colors.white,
                ),
                //backgroud linear
                Container(
                  width: size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade100,
                        kDefualtColorMain,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                //top container
                Positioned(
                  top: 80,
                  right: 0,
                  left: 0,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                    width: size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefualtPadding,
                              vertical: kDefualtPadding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${petData[0].image}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'พลอากาศเอกฟูฟู่',
                                    style: GoogleFonts.mitr(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'แก้ไข',
                                    style: GoogleFonts.mitr(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: size.width,
              height:
                  size.height >= 920 ? size.height * 0.5 : size.height * 0.6,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                // width: size.width,
                // height:
                //     size.height < 685 ? size.height * 0.6 : size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    ProfileForm(size, _usernameController, 'Username'),
                    SizedBox(height: 5),
                    ProfileForm(size, _usernameController, 'Email'),
                    SizedBox(height: 5),
                    ProfileForm(size, _usernameController, 'Tel'),
                    SizedBox(height: 5),
                    ProfileForm(size, _usernameController, 'Address'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget ProfileForm(
      Size size, TextEditingController _textcontroller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefualtPadding,
        vertical: kDefualtPadding,
      ),
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          // border: Border.all(),
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding / 2),
          child: TextFormField(
            controller: _textcontroller,
            // initialValue: initialValue,
            decoration:
                InputDecoration(border: InputBorder.none, label: Text(label)),
          ),
        ),
      ),
    );
  }
}
