import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petty/core/models/user_model.dart';
import '../services/db.dart';

class Users with ChangeNotifier {
  List<User> _user = [User(id: '1', name: 'Usuario', email: '', password: '')];

  Future loadUser() async {
    final _dataList = await DbUtil.getData('user');
    _user = _dataList
        .map((item) => User(
              id: item['id'],
              name: item['name'],
              image: File(item['image']),
              email: '',
              password: '',
            ))
        .toList();
    notifyListeners();
  }

  List<User> get user => [..._user];

  void addUser(String id, String name, image) {
    final user =
        User(name: name, id: id, image: image, email: '', password: '');

    DbUtil.insert('user', {
      'id': user.id,
      'name': user.name,
      'image': user.image != null ? user.image!.path : user.image!,
    });
    notifyListeners();
  }
}
