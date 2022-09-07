import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petty/models/pet_model.dart';
import 'package:petty/models/vaccine_model.dart';

class VaccineForm extends StatelessWidget {
  VaccineForm({Key? key, required this.pet, required this.addVaccine})
      : super(key: key);

  Pet pet;
  Function(Vaccine) addVaccine;
  final nameController = TextEditingController();

  Vaccine _formVaccine(String vaccineName, petId) {
    Vaccine vaccine = Vaccine(
        id: Random().nextDouble().toString(),
        petId: petId,
        vaccinename: vaccineName);

    return vaccine;
  }

  @override
  Widget build(BuildContext context) {
    void _submitForm() {
      Vaccine vaccine = _formVaccine(nameController.text, pet.id);
      addVaccine(vaccine);
      Navigator.of(context).pop();
    }

    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                label: Text('Nome'),
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child: TextButton(
              onPressed: _submitForm,
              child: Text(
                'Adicionar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
