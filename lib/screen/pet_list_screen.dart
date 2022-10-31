import 'package:flutter/material.dart';
import 'package:petty/components/card_pet.dart';
import 'package:petty/provider/pet_list.dart';
import 'package:petty/screen/pet_form_screen.dart';
import 'package:provider/provider.dart';

class PetListScreen extends StatelessWidget {
  const PetListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetList>(context);

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 24, 16, 64),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meus Pets',
                  style: Theme.of(context).textTheme.headline1,
                ),
                FutureBuilder(
                  future: provider.loadPets(),
                  builder: (BuildContext context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: provider.petsCount,
                                itemBuilder: (context, index) => CardPet(
                                  pet: provider.pets[index],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 24, 16, 64),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PetFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
