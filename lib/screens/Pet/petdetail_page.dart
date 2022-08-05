import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcare_project/controllers/pet_controller.dart';

class PetDetailPage extends StatefulWidget {
  const PetDetailPage({Key? key}) : super(key: key);

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  final PetController _petController = Get.find<PetController>();

  @override
  Widget build(BuildContext context) {
    print(Get.arguments[0]);
    print(Get.arguments[1]);
    return Scaffold(
      body: Hero(
        tag: '${Get.arguments[1]}',
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('${Get.arguments[0]}'),
            ),
          ),
          child: Text('${Get.arguments[1]},'),
        ),
      ),
    );
  }
}
