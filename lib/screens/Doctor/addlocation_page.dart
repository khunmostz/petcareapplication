import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare_project/controllers/addlocation_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final AddLocationController _addLocationController =
      Get.put(AddLocationController());

  List<String> typeLocation = [
    'Groomer',
    'Hospital',
    'Exotic',
    'Pet Hotel',
    'Pet Cafe',
    'Pet Shop'
  ];

  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Hero(
                      tag: 'addlocation',
                      child: Text(
                        'เพิ่มโลเคชั่น',
                        style: GoogleFonts.mitr(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.amber,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: (() {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: ((context) {
                              return Padding(
                                padding: const EdgeInsets.all(kDefualtPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ImageSourceItem(size, ImageSource.camera,
                                        Icon(Icons.camera_enhance_sharp)),
                                    ImageSourceItem(size, ImageSource.gallery,
                                        Icon(Icons.broken_image)),
                                  ],
                                ),
                              );
                            }),
                          );
                        }),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FormField(
                  controller: _addLocationController.establishmentController,
                  hintText: 'ชื่อสถานประกอบการ',
                  prefixIcon: Icon(Icons.local_hospital),
                  maxLines: 1,
                ),
                SizedBox(height: 10),
                FormField(
                  controller: _addLocationController.descriptionController,
                  hintText: 'รายละเอียด',
                  prefixIcon: Icon(Icons.description),
                  maxLines: 4,
                ),
                SizedBox(height: 10),
                FormField(
                  controller: _addLocationController.nameDoctorController,
                  hintText: 'ชื่อคุณหมอ',
                  prefixIcon: Icon(Icons.account_box),
                  maxLines: 1,
                ),
                SizedBox(height: 10),
                FormField(
                  controller: _addLocationController.emailController,
                  hintText: 'อีเมลล์',
                  prefixIcon: Icon(Icons.email),
                  maxLines: 1,
                ),
                SizedBox(height: 10),
                FormField(
                  controller: _addLocationController.telController,
                  hintText: 'เบอร์',
                  prefixIcon: Icon(Icons.phone),
                  maxLines: 1,
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: 'ยืนยัน',
                  onPressed: () {
                    _addLocationController.addDoctor();
                  },
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: 'test post',
                  onPressed: () {
                    print('post');
                    _addLocationController.test();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ImageSourceItem(Size size, ImageSource imageSource, Icon icon) {
    return GestureDetector(
      onTap: (() {
        _addLocationController.uploadLocationImage(imageSource: imageSource);
      }),
      child: Container(
          width: size.width,
          height: 100,
          decoration: BoxDecoration(
            color: kDefualtColorMain,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: icon),
    );
  }

  Widget DropdownMenu(Size size) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            Icon(
              Icons.list,
              // size: 16,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Select Item',
                style: GoogleFonts.mitr(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: typeLocation
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        value: _selectedValue,
        onChanged: ((value) {
          setState(() {
            _selectedValue = value as String;
          });
        }),
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        // iconSize: 14,
        iconEnabledColor: kDefualtColorMain,
        iconDisabledColor: Colors.grey,
        buttonHeight: 60,
        buttonWidth: size.width,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          // border: Border.all(
          //   color: Colors.black26,
          // ),
          color: Colors.white,
        ),
        buttonElevation: 0,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: size.width,
        dropdownWidth: size.width * 0.9,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        // offset: const Offset(-20, 0),
      ),
    );
  }

  Widget FormField(
      {required TextEditingController controller,
      required String hintText,
      required Icon prefixIcon,
      required int maxLines}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      autofocus: true,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: GoogleFonts.mitr(fontSize: 16),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
