import 'package:flutter/material.dart';
import 'package:petty/page/auth/models/auth_model.dart';
import 'package:petty/page/auth/userForm/user_form_page.dart';
import 'package:petty/page/home/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Auth.instance.token,
        builder: (BuildContext context, String value, Widget? child) {
          return value != '' ? HomePage() : UserFormPage();
        });
  }
}
