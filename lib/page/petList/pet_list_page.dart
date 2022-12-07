import 'package:flutter/material.dart';
import 'package:petty/page/petList/components/card_pet.dart';
import 'package:petty/page/petForm/pet_form_page.dart';
import 'package:petty/page/home/controller/home_controller.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petList = PetList();

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 24, 16, 64),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(40)),
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
                  future: petList.loadPets(),
                  builder: (BuildContext context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: petList.petsCount,
                                itemBuilder: (context, index) => CardPet(
                                  pet: petList.pets[index],
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
        backgroundColor: const Color.fromARGB(255, 24, 16, 64),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PetFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
