import 'package:flutter/material.dart';
import 'package:petty/core/controller/user.dart';
import 'package:petty/core/utils/app_routes.dart';
import 'package:petty/page/auth/models/auth_model.dart';
import 'package:petty/page/auth/userForm/user_form_page.dart';
import 'package:petty/page/settings/controller/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Users user = Users();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 24, 16, 64),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: Settings.instance.isDarkMode,
                  onChanged: (value) {
                    Settings.instance.switchTheme();
                  },
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.userForm),
                child: const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Login'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.key),
                title: Text('Mudar Senha'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              const ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notificacoes'),
                trailing: Switch(value: false, onChanged: null),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.language),
                child: const ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Idioma'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              InkWell(
                onTap: () {
                  Auth.instance.token.value = '';
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// AnimatedBuilder(
              //   animation: user,
              //   builder: (BuildContext context, Widget? child) {
              //     return ListTile(
              //       leading: Container(
              //           height: 50,
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(50),
              //           ),
              //           child: user.user[0].image != null
              //               ? ClipRRect(
              //                   borderRadius: BorderRadius.circular(120),
              //                   child: Image.file(
              //                     user.user[0].image!,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 )
              //               : ClipRRect(
              //                   borderRadius: BorderRadius.circular(120),
              //                   child: Image.asset(
              //                     'assets/photo-1588421357574-87938a86fa28.jpeg',
              //                     fit: BoxFit.cover,
              //                   ),
              //                 )),
              //       title: Text(user.user[0].name),
              //       subtitle: const Text('Editar detalhes'),
              //       trailing: IconButton(
              //           onPressed: () => Navigator.of(context)
              //               .pushNamed(AppRoutes.USER_FORM),
              //           icon: const Icon(Icons.arrow_forward_ios_outlined)),
              //     );
              //   },
              // ),