import 'package:flutter/material.dart';
import 'package:petty/core/models/user_model.dart';
import 'package:petty/page/auth/exceptions/auth_exception.dart';
import 'package:petty/page/auth/services/auth_service.dart';

class FormerButton extends StatelessWidget {
  FormerButton(
      {Key? key,
      required this.formKey,
      required this.newUser,
      required this.user})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  bool newUser;
  User user;
  final service = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showErrorDialog(String msg) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreo um Erro'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        ),
      );
    }

    Future<void> _submit() async {
      final isValid = formKey.currentState?.validate() ?? false;

      if (!isValid) {
        return;
      }

      formKey.currentState?.save();

      try {
        if (newUser == true) {
          await service.signup(
            user.email,
            user.password,
          );
          await service.login(
            user.email,
            user.password,
          );
        } else {
          await service.login(
            user.email,
            user.password,
          );
        }
      } on AuthException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        _showErrorDialog('Ocorreu um erro inesperado!');
      }
    }

    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
        ),
        onPressed: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () {
              _submit();
            },
            child: Center(
              child: newUser
                  ? const Text(
                      'Criar Conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )
                  : const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
