import 'package:flutter/material.dart';
import 'package:petty/models/vaccine_date_model.dart';
import 'package:petty/models/vaccine_model.dart';
import 'package:petty/utils/db.dart';

class VaccineDateList with ChangeNotifier {
  List<VaccineModelDate> _vaccineDateList = [];

  Future loadVaccineDate(Vaccine vaccine) async {
    final dataList = await DbUtil.getData('vaccinedate');
    _vaccineDateList = dataList
        .map(
          (item) => VaccineModelDate(
            id: item['id'],
            vaccineId: item['vaccineid'],
            date: DateTime.parse(item['vaccinedate']),
            dateLimit: item['vaccinedatelimit'],
          ),
        )
        .toList()
        .where((element) => element.vaccineId == vaccine.id)
        .toList();
  }

  int get vaccineDateCount => _vaccineDateList.length;

  List<VaccineModelDate> get vaccineDateList =>
      _vaccineDateList.reversed.toList();

  void addVaccineDate(VaccineModelDate vaccineDate) {
    DbUtil.insert('vaccinedate', {
      'id': vaccineDate.id,
      'vaccineid': vaccineDate.vaccineId,
      'vaccinedate': vaccineDate.date.toString(),
      'vaccinedatelimit': vaccineDate.dateLimit,
    });
    notifyListeners();
  }

  void deleteVaccineDate(String id) {
    DbUtil.deleteData('vaccinedate', id);
    notifyListeners();
  }
}
