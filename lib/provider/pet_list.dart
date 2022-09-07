import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petty/models/pet_model.dart';
import 'package:petty/utils/db.dart';

class PetList with ChangeNotifier {
  List<Pet> _pets = [];

  Future loadPets() async {
    final dataList = await DbUtil.getData('pet');
    _pets = dataList
        .map(
          (item) => Pet(
            id: item['id'],
            name: item['name'],
            age: item['age'],
            sex: item['sex'],
            breed: item['breed'],
            image: File(item['image']),
            weight: item['weight'],
          ),
        )
        .toList();
    print('carregou');
  }

  int get petsCount => _pets.length;

  List<Pet> get pets => [..._pets];

  void addPets(
    name,
    age,
    breed,
    sex,
    image,
    weight,
  ) {
    final pet = Pet(
      id: Random().nextDouble().toString(),
      name: name,
      age: age,
      breed: breed,
      sex: sex,
      image: image,
      weight: weight,
    );

    DbUtil.insert('pet', {
      'id': pet.id,
      'name': pet.name,
      'age': pet.age,
      'sex': pet.sex,
      'breed': pet.breed,
      'image': pet.image != null ? pet.image!.path : pet.image!,
      'weight': pet.weight,
    });
    notifyListeners();
  }

  void deletePets(String id) {
    DbUtil.deleteData('pet', id);
    notifyListeners();
  }

  void updateWeightPet(Pet pet, String weight) {
    Map<String, dynamic> petupdated = {
      'id': pet.id,
      'name': pet.name,
      'age': pet.age,
      'sex': pet.sex,
      'breed': pet.breed,
      'image': pet.image != null ? pet.image!.path : pet.image!,
      'weight': weight,
    };
    DbUtil.updateData('pet', petupdated, pet.id);
  }
}
