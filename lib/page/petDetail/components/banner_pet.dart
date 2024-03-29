import 'package:flutter/material.dart';
import 'package:petty/core/models/pet_model.dart';
import 'package:petty/page/home/controller/home_controller.dart';

class BannerPet extends StatelessWidget {
  const BannerPet({Key? key, required this.pet}) : super(key: key);
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final petList = PetList();
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: pet.image != null
              ? Hero(
                  tag: pet.id,
                  child: Image.file(
                    pet.image!,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ),
        Positioned(
          top: 180,
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.6),
                  Color.fromRGBO(0, 0, 0, 0),
                ],
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.pets,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    pet.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 230,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 120,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 5,
                    child: Center(
                      child: Text(
                        'Idade: ${pet.age}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => petList.updateWeightPet(pet, pet.weight),
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: Card(
                      color: Theme.of(context).cardColor,
                      elevation: 5,
                      child: Center(
                        child: Text(
                          'Peso: ${pet.weight} Kg',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 5,
                    child: Center(
                      child: Text(
                        'Sexo: ${pet.sex}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
