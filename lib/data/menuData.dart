import 'package:flutter/material.dart';

class MenuData {
  final Icon? icon;
  final String? titleMenu;

  MenuData({
    required this.icon,
    required this.titleMenu,
  });
}

List<MenuData> menuTitleData = [
  MenuData(icon: Icon(Icons.person), titleMenu: "Menu 1"),
  MenuData(icon: Icon(Icons.person), titleMenu: "Menu 2"),
  MenuData(icon: Icon(Icons.person), titleMenu: "Menu 3"),
  MenuData(icon: Icon(Icons.person), titleMenu: "Menu 4"),
  MenuData(icon: Icon(Icons.person), titleMenu: "Menu 5"),
  MenuData(icon: Icon(Icons.person), titleMenu: "Menu 6"),
];
