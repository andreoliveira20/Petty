import 'dart:io';

import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String id;
  String name;
  String email;
  String password;
  File? image;

  User({
    required this.name,
    this.image,
    required this.id,
    required this.email,
    required this.password,
  });
}
