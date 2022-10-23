import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

enum dateTimeMonth {
  threeMonth,
  sixMonth,
  TwenthMonth,
}

class _VaccineFormState extends State<VaccineFormDate> {
  DateTime _selectedDate = DateTime.now();
  var dayTime = '${DateFormat('dd').format(
    DateTime.now(),
  )}';
  var monthTime = '${DateFormat('MM').format(
    DateTime.now(),
  )}';
  var yearTime = '${DateFormat('y').format(
    DateTime.now(),
  )}';

  var _dateLimit = '3';

  VaccineModelDate _submitVaccine(
      String vaccineId, DateTime date, String dateLimit) {
    VaccineModelDate vaccineDate = VaccineModelDate(
      id: Random().nextDouble().toString(),
      vaccineId: vaccineId,
      date: date,
      dateLimit: dateLimit,
    );

    return vaccineDate;
  }

  void ConvertdateLimit() {
    if (timeMonth == dateTimeMonth.threeMonth) {
      _dateLimit = '3';
      return;
    }
    if (timeMonth == dateTimeMonth.sixMonth) {
      _dateLimit = '6';
      return;
    }
    if (timeMonth == dateTimeMonth.TwenthMonth) {
      _dateLimit = '12';
      return;
    }
  }

  dateTimeMonth timeMonth = dateTimeMonth.threeMonth;

  @override
  Widget build(BuildContext context) {
    _submitForm() {
      ConvertdateLimit();
      _selectedDate = DateTime.parse('${yearTime}${monthTime}${dayTime}');
      final vaccineDate =
          _submitVaccine(widget.vaccine.id, _selectedDate, _dateLimit);

      widget.addVaccine(vaccineDate);
      Navigator.of(context).pop();
    }

    return Card(
      child: Column(
        children: [
          Text('Data da aplicacao'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 128),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    autocorrect: false,
                    enableSuggestions: false,
                    maxLength: 2,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onChanged: (String value) {
                      dayTime = value;
                    },
                    decoration: InputDecoration(
                      counterText: '',
                    ),
                    keyboardType: TextInputType.datetime,
                    initialValue: '${DateFormat('dd').format(
                      _selectedDate,
                    )}',
                  ),
                ),
                Text(
                  '/',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    autocorrect: false,
                    enableSuggestions: false,
                    maxLength: 2,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onChanged: (String value) {
                      monthTime = value;
                    },
                    decoration: InputDecoration(
                      counterText: '',
                    ),
                    keyboardType: TextInputType.datetime,
                    initialValue: '${DateFormat('MM').format(
                      _selectedDate,
                    )}',
                  ),
                ),
                Text(
                  '/',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    autocorrect: false,
                    enableSuggestions: false,
                    maxLength: 4,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onChanged: (String value) {
                      yearTime = value;
                    },
                    decoration: InputDecoration(
                      counterText: '',
                    ),
                    keyboardType: TextInputType.datetime,
                    initialValue: '${DateFormat('y').format(
                      _selectedDate,
                    )}',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    timeMonth = dateTimeMonth.threeMonth;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: timeMonth == dateTimeMonth.threeMonth
                        ? Color.fromARGB(255, 255, 120, 1)
                        : null,
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('3 meses'),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    timeMonth = dateTimeMonth.sixMonth;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: timeMonth == dateTimeMonth.sixMonth
                        ? Color.fromARGB(255, 255, 120, 1)
                        : null,
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('6 meses'),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    timeMonth = dateTimeMonth.TwenthMonth;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: timeMonth == dateTimeMonth.TwenthMonth
                        ? Color.fromARGB(255, 255, 120, 1)
                        : null,
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('12 meses'),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Registrar',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
