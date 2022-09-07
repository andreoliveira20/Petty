import 'dart:io';

import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String id;
  String name;
  File? image;

  User({required this.name, this.image, required this.id});
}
