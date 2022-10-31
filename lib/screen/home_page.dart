import 'package:flutter/material.dart';
import 'package:petty/components/top_bar.dart';
import 'package:petty/provider/user.dart';
import 'package:petty/screen/pet_list_screen.dart';
import 'package:petty/screen/settings.screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
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
    final userProvider = Provider.of<Users>(context);

    List<Widget> _widgetOptions = <Widget>[
      PetListScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: FutureBuilder(
          future: userProvider.loadUser(),
          builder: (BuildContext context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : TopBar(
                      user: userProvider.user[0],
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
