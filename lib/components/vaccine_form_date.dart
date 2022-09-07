import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petty/models/vaccine_date_model.dart';
import 'package:petty/models/vaccine_model.dart';

class VaccineFormDate extends StatefulWidget {
  VaccineFormDate({Key? key, required this.vaccine, required this.addVaccine})
      : super(key: key);
  Vaccine vaccine;
  void Function(VaccineModelDate) addVaccine;

  @override
  State<VaccineFormDate> createState() => _VaccineFormState();
}

class _VaccineFormState extends State<VaccineFormDate> {
  DateTime _selectedDate = DateTime.now();

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  VaccineModelDate _submitVaccine(String vaccineId, DateTime date) {
    VaccineModelDate vaccineDate = VaccineModelDate(
      id: Random().nextDouble().toString(),
      vaccineId: vaccineId,
      date: date,
    );

    return vaccineDate;
  }

  @override
  Widget build(BuildContext context) {
    _submitForm() {
      final vaccineDate = _submitVaccine(widget.vaccine.id, _selectedDate);

      widget.addVaccine(vaccineDate);
      Navigator.of(context).pop();
    }

    return Card(
      child: Column(
        children: [
          Text('Data da aplicacao'),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'selecionar data'
                      : 'Data selecionada ${DateFormat('dd/MM/y').format(
                          _selectedDate,
                        )}'),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
        ],
      ),
    );
  }
}
