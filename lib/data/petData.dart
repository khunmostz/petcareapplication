import 'package:flutter/material.dart';

class Pet {
  late int id;
  late String name, description, image;
  late List<String> listexpenses;
  late int expenses;
  late DateTime date;

  Pet({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.listexpenses,
    required this.expenses,
    required this.date,
  });
}

List<Pet> petData = [
  Pet(
    id: 1,
    name: "Fufu",
    description: "พลอากาศเอก",
    image: "https://pbs.twimg.com/media/EIXRmJFWwAAoGhH.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
  Pet(
    id: 2,
    name: "Kuy",
    description: "พลอากาศเอก",
    image: "https://img.pptvhd36.com/thumbor/2022/01/26/771eebf1b8.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
  Pet(
    id: 3,
    name: "Alice 1",
    description: "พลอากาศเอก",
    image: "https://thestandard.co/wp-content/uploads/2020/02/25-1.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
  Pet(
    id: 4,
    name: "Alice 2",
    description: "พลอากาศเอก",
    image: "https://thestandard.co/wp-content/uploads/2020/02/25-1.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
  Pet(
    id: 5,
    name: "Alice 3",
    description: "พลอากาศเอก",
    image: "https://thestandard.co/wp-content/uploads/2020/02/25-1.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
  Pet(
    id: 5,
    name: "Alice 3",
    description: "พลอากาศเอก",
    image: "https://thestandard.co/wp-content/uploads/2020/02/25-1.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
  Pet(
    id: 5,
    name: "Alice 3",
    description: "พลอากาศเอก",
    image: "https://thestandard.co/wp-content/uploads/2020/02/25-1.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
  Pet(
    id: 5,
    name: "Alice 3",
    description: "พลอากาศเอก",
    image: "https://thestandard.co/wp-content/uploads/2020/02/25-1.jpg",
    listexpenses: ['ค่าเครื่องแบบ'],
    expenses: 5000,
    date: DateTime.now(),
  ),
];
