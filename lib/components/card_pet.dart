import 'package:flutter/material.dart';
import 'package:petty/provider/pet_list.dart';
import 'package:petty/models/pet_model.dart';
import 'package:petty/utils/app_routes.dart';
import 'package:provider/provider.dart';

class CardPet extends StatelessWidget {
  final Pet pet;
  const CardPet({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(AppRoutes.PET_DETAIL, arguments: pet),
      child: Card(
        elevation: 5,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
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
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.breed,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      pet.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${pet.age} anos',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () =>
                        Provider.of<PetList>(context, listen: false)
                            .deletePets(pet.id),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}