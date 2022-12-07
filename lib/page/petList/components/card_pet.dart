import 'package:flutter/material.dart';
import 'package:petty/core/models/pet_model.dart';
import 'package:petty/core/utils/app_routes.dart';
import 'package:petty/page/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CardPet extends StatelessWidget {
  final Pet pet;
  const CardPet({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(AppRoutes.petDetail, arguments: pet),
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
                      ? Hero(
                          tag: pet.id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: Image.file(
                              pet.image!,
                              fit: BoxFit.cover,
                            ),
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
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      pet.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '${pet.age} anos',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                const Spacer(),
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
