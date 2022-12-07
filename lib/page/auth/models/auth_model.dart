import 'package:flutter/cupertino.dart';

class Auth {
  final token = ValueNotifier<String>('');
  String? name;
  String? email;
  String? uid;
  DateTime? expiryDate;

  Auth._();
  static final instance = Auth._();
}
