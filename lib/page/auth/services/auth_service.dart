import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:petty/page/auth/exceptions/auth_exception.dart';
import 'package:petty/page/auth/models/auth_model.dart';

class AuthService extends ChangeNotifier {
  static const _urlSignup =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA5IF2wNQ_bGAlMA0Ta_3x1I17O09uzWbE';

  static const _urlSignin =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA5IF2wNQ_bGAlMA0Ta_3x1I17O09uzWbE';

  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse(_urlSignup),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }

    print(body);
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_urlSignin),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      Auth.instance.token.value = body['idToken'];
      Auth.instance.email = body['email'];
      Auth.instance.uid = body['localId'];

      Auth.instance.expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      notifyListeners();
    }

    print(body);
  }
}
