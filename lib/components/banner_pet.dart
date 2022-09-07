import 'package:flutter/material.dart';
import 'package:petty/models/pet_model.dart';
import 'package:petty/provider/pet_list.dart';
import 'package:provider/provider.dart';

class BannerPet extends StatelessWidget {
  BannerPet({required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetList>(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          color: Color.fromARGB(255, 24, 16, 64),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: pet.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: Image.file(
                              pet.image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    pet.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 120,
                  child: Card(
                    color: Color.fromARGB(255, 241, 232, 219).withOpacity(0.9),
                    elevation: 5,
                    child: Center(
                      child: Text(
                        'Idade: ${pet.age}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => provider.updateWeightPet(pet, pet.weight),
                  child: Container(
                    height: 50,
                    width: 100,
                    child: Card(
                      color:
                          Color.fromARGB(255, 241, 232, 219).withOpacity(0.9),
                      elevation: 5,
                      child: Center(
                        child: Text(
                          'Peso: ${pet.weight} Kg',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Card(
                    color: Color.fromARGB(255, 241, 232, 219).withOpacity(0.9),
                    elevation: 5,
                    child: Center(
                      child: Text(
                        'Sexo: ${pet.sex}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
