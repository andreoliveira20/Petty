import 'dart:io';

import 'package:flutter/material.dart';

class Pet with ChangeNotifier {
  String id;
  String name;
  String age;
  String sex;
  String breed;
  File? image;
  String weight;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.breed,
    required this.image,
    required this.weight,
  });
}
