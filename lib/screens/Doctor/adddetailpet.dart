import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/adddetailpet_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';

class AddDetailPet extends StatefulWidget {
  const AddDetailPet({Key? key}) : super(key: key);

  @override
  State<AddDetailPet> createState() => _AddDetailPetState();
}

class _AddDetailPetState extends State<AddDetailPet> {
  final AddDetailPetController _addDetailPetController =
      Get.put(AddDetailPetController());
  @override
  Widget build(BuildContext context) {
    var petname = Get.arguments[0];
    var image = Get.arguments[1];
    var type = Get.arguments[2];
    var species = Get.arguments[3];
    var gender = Get.arguments[4];
    var weight = Get.arguments[5];

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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: Text(
                'เพิ่มข้อมูลการักษา',
                style: GoogleFonts.mitr(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.green,
                  backgroundImage: NetworkImage('${image}'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ชื่อ ${petname}',
                style: GoogleFonts.mitr(
                  fontSize: 20,
                ),
              ),
              Text(
                'เพศ ${gender} / น้ำหนัก ${weight}',
                style: GoogleFonts.mitr(
                  fontSize: 20,
                ),
              ),
              Text(
                'ประเภท ${type} / พันธุ์ ${species}',
                style: GoogleFonts.mitr(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              myFormField(_addDetailPetController.dateTimeController,
                  Icon(Icons.calendar_today), 'วันที่', 1, true),
              SizedBox(height: 20),
              myFormField(_addDetailPetController.desController,
                  Icon(Icons.description), 'รายละเอียด', 5, false),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: CustomButton(
                  text: 'ยืนยัน',
                  onPressed: () =>
                      _addDetailPetController.addPetTreat(petName: petname),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myFormField(TextEditingController controller, Icon icon,
      String hintText, int maxLines, bool readOnly) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: hintText,
          hintStyle: GoogleFonts.mitr(
            fontSize: 16,
            color: Colors.grey,
          ),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
