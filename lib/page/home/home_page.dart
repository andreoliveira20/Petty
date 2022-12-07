import 'package:flutter/material.dart';
import 'package:petty/core/controller/user.dart';
import 'package:petty/page/home/components/top_bar.dart';
import 'package:petty/page/petList/pet_list_page.dart';
import 'package:petty/page/settings/settings.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Users();

    List<Widget> _widgetOptions = <Widget>[
      PetListPage(),
      SettingsPage(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: FutureBuilder(
          future: user.loadUser(),
          builder: (BuildContext context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : TopBar(
                      user: user.user[0],
                    ),
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 24, 16, 64),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pets,
            ),
            label: 'Pet',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Configuracoes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 120, 1),
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        iconSize: 30,
      ),
    );
  }
}
