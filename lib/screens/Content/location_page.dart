import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var locationName = Get.arguments[0];
    var locationImage = Get.arguments[1];
    var locationDesc = Get.arguments[2];
    var locationLat = Get.arguments[3];
    var locationLong = Get.arguments[4];

    print('lat' + locationLat);
    print('long' + locationLong);

    //lat long มาใส่
    Future<void> openMap(BuildContext context, double lat, double lng) async {
      String url = '';
      String urlAppleMaps = '';
      if (Platform.isAndroid) {
        url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      } else {
        urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
        url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }

      if (await canLaunch(url)) {
        await launch(url);
      } else if (await canLaunch(urlAppleMaps)) {
        await launch(urlAppleMaps);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                locationName,
                style: GoogleFonts.mitr(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width,
                height: size.height * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(locationImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                text: 'นำทาง',
                onPressed: () async {
                  openMap(
                    context,
                    double.parse(locationLat),
                    double.parse(locationLong),
                  );
                },
              ),
              SizedBox(height: 30),
              Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    locationDesc,
                    style: GoogleFonts.mitr(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ));
  }
}
