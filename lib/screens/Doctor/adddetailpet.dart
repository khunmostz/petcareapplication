import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDetailPet extends StatefulWidget {
  const AddDetailPet({Key? key}) : super(key: key);

  @override
  State<AddDetailPet> createState() => _AddDetailPetState();
}

class _AddDetailPetState extends State<AddDetailPet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 248, 135, 100),
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [],
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
