import 'package:flutter/material.dart';

class MenuData {
  final String? image;
  final String? titleMenu;
  final String? type;

  MenuData({required this.image, required this.titleMenu, required this.type});
}

List<MenuData> menuTitleData = [
  MenuData(
      image: 'assets/icon/groomer.png', titleMenu: "Groomer", type: 'Groomer'),
  MenuData(
    image: 'assets/icon/hospital-building.png',
    titleMenu: "Hospital",
    type: 'Hospital',
  ),
  MenuData(
      image: 'assets/icon/clinic.png', titleMenu: "Clinic", type: 'Clinic'),
  MenuData(
    image: 'assets/icon/pet-hotel.png',
    titleMenu: "Pet Hotel",
    type: 'Pet Hotel',
  ),
  MenuData(
    image: 'assets/icon/pet-love.png',
    titleMenu: "Pet Love",
    type: 'Pet Love',
  ),
  MenuData(
    image: 'assets/icon/pet-shop.png',
    titleMenu: "Pet Shop",
    type: 'Pet Shop',
  ),
];
