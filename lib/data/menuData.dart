import 'package:flutter/material.dart';

class MenuData {
  final String? image;
  final String? titleMenu;

  MenuData({
    required this.image,
    required this.titleMenu,
  });
}

List<MenuData> menuTitleData = [
  MenuData(image: 'assets/icon/groomer.png', titleMenu: "Groomer"),
  MenuData(image: 'assets/icon/hospital-building.png', titleMenu: "Hospital"),
  MenuData(image: 'assets/icon/clinic.png', titleMenu: "Clinic"),
  MenuData(image: 'assets/icon/pet-hotel.png', titleMenu: "Pet Hotel"),
  MenuData(image: 'assets/icon/pet-love.png', titleMenu: "Pet Love"),
  MenuData(image: 'assets/icon/pet-shop.png', titleMenu: "Pet Shop"),
];
