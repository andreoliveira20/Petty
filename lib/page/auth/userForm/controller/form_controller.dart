import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormController extends ChangeNotifier {
  File? _storedImage;
  final _controller = TextEditingController();
  bool _newUser = false;

  get storedImage => _storedImage;
  get takePictureCamera => _takePictureCamera;
  get takePictureGallery => _takePictureGallery;
  get controller => _controller;
  get newUser => _newUser;
  get switchNewUser => _switchNewUser;

  _takePictureCamera() async {
    final ImagePicker _picker = ImagePicker();
    var imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    _storedImage = File(imageFile.path);
    notifyListeners();
  }

  _takePictureGallery() async {
    final ImagePicker _picker = ImagePicker();
    var imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile == null) return;

    _storedImage = File(imageFile.path);
    notifyListeners();
  }

  _switchNewUser() {
    _newUser = !_newUser;
    notifyListeners();
  }
}
