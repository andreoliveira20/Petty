import 'package:flutter/material.dart';
import 'package:petty/models/pet_model.dart';
import 'package:petty/models/vaccine_model.dart';
import 'package:petty/utils/db.dart';

class VaccineList with ChangeNotifier {
  List<Vaccine> _vaccineList = [];

  Future loadVaccine(Pet pet) async {
    final dataList = await DbUtil.getData('vaccine');
    _vaccineList = dataList
        .map(
          (item) => Vaccine(
            id: item['id'],
            vaccinename: item['vaccinename'],
            petId: item['petid'],
          ),
        )
        .toList()
        .where((element) => element.petId == pet.id)
        .toList();
  }

  int get vaccineCount => _vaccineList.length;

  List<Vaccine> get vaccineList => [..._vaccineList];

  void addVaccine(Vaccine vaccine) {
    DbUtil.insert('vaccine', {
      'id': vaccine.id,
      'vaccinename': vaccine.vaccinename,
      'petid': vaccine.petId
    });
    notifyListeners();
  }

  void deleteVaccine(String id) {
    DbUtil.deleteData('vaccine', id);
    notifyListeners();
  }
}
