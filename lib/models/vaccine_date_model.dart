import 'package:flutter/material.dart';

class VaccineModelDate with ChangeNotifier {
  String id;
  String vaccineId;
  String dateLimit;
  DateTime date;

  VaccineModelDate(
      {required this.id,
      required this.vaccineId,
      required this.date,
      required this.dateLimit});
}
