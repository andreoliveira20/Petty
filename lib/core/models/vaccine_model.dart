import 'package:flutter/cupertino.dart';

class Vaccine with ChangeNotifier {
  String id;
  String petId;
  String vaccinename;

  Vaccine({
    required this.id,
    required this.petId,
    required this.vaccinename,
  });
}
