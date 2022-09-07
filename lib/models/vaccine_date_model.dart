import 'package:flutter/material.dart';

class VaccineModelDate with ChangeNotifier {
  String id;
  String vaccineId;
  DateTime date;

  VaccineModelDate(
      {required this.id, required this.vaccineId, required this.date});
}
