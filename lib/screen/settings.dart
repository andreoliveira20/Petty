import 'package:flutter/material.dart';
import 'package:petty/provider/user.dart';
import 'package:petty/utils/app_routes.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Users>(context);
    return Container(
      color: Color.fromARGB(255, 24, 16, 64),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 230, 230),
          borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: userProvider.user[0].image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: Image.file(
                              userProvider.user[0].image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: Image.asset(
                              'assets/photo-1588421357574-87938a86fa28.jpeg',
                              fit: BoxFit.cover,
                            ),
                          )),
                title: Text(userProvider.user[0].name),
                subtitle: Text('Editar detalhes'),
                trailing: IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.USER_FORM),
                    icon: Icon(Icons.arrow_forward_ios_outlined)),
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text('Dark Mode'),
                trailing: Switch(value: false, onChanged: null),
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Editar Perfil'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              ListTile(
                leading: Icon(Icons.key),
                title: Text('Mudar Senha'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notificacoes'),
                trailing: Switch(value: false, onChanged: null),
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Idioma'),
                trailing: IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.LANGUAGE),
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
