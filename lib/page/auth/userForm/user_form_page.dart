import 'package:flutter/material.dart';
import 'package:petty/core/models/user_model.dart';
import 'package:petty/page/auth/userForm/components/custom_form_field_widget.dart';
import 'package:petty/page/auth/userForm/components/former_button_widget.dart';
import 'package:petty/page/auth/userForm/controller/form_controller.dart';
import 'package:validatorless/validatorless.dart';
import 'components/picture_form_field_widget.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({Key? key}) : super(key: key);

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final User user = User(name: '', id: '', email: '', password: '');
  final controller = FormController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.newUser
            ? const Text('Novo Usuario',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ))
            : const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PictureFormField(
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    if (controller.newUser)
                      CustomFormField(
                        labelText: 'Name',
                        hintText: 'Type your name',
                        onSaved: (text) => user.name = text!,
                        validator:
                            Validatorless.required('The field is required'),
                      ),
                    CustomFormField(
                      labelText: 'Email',
                      hintText: 'Type your e-mail',
                      onSaved: (text) => user.email = text!,
                      validator: Validatorless.multiple(
                        [
                          Validatorless.email('The field must be an email'),
                          Validatorless.required('The field is required'),
                        ],
                      ),
                    ),
                    CustomFormField(
                      labelText: 'Password',
                      hintText: 'Type your password',
                      controller: controller.controller,
                      onSaved: (text) => user.password = text!,
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('The field is required'),
                          Validatorless.min(6, 'Minimun 6 character'),
                        ],
                      ),
                    ),
                    if (controller.newUser)
                      CustomFormField(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('The field is required'),
                            Validatorless.compare(controller.controller,
                                'The password does not match'),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              FormerButton(
                formKey: formKey,
                newUser: controller.newUser,
                user: user,
              ),
              Center(
                child: TextButton(
                  onPressed: controller.switchNewUser,
                  child: controller.newUser
                      ? const Text('Voce ja tem conta? Login')
                      : const Text('Cadastre-se'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
