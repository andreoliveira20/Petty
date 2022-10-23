import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petty/models/vaccine_date_model.dart';

class VaccineCardDate extends StatelessWidget {
  VaccineCardDate({required this.vaccineDate, required this.onRemove});
  final VaccineModelDate vaccineDate;
  void Function(String) onRemove;

  bool dateExpiredFunction() {
    if (DateTime.now().year >= vaccineDate.date.add(Duration(days: 365)).year) {
      if (DateTime.now().month >=
          vaccineDate.date.add(Duration(days: 365)).month) {
        if (DateTime.now().day >
            vaccineDate.date.add(Duration(days: 365)).day) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    int dateLimit = int.parse(vaccineDate.dateLimit) * 30;
    bool dateExpired = dateExpiredFunction();

    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(50),
            right: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: dateExpired ? Colors.red : Colors.green,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    'Aplicacao',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${DateFormat('dd/MM/y').format(
                    vaccineDate.date,
                  )}')
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                children: [
                  Text(
                    'Vencimento',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${DateFormat('dd/MM/y').format(
                    vaccineDate.date.add(Duration(days: dateLimit)),
                  )}'),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () => onRemove(vaccineDate.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ));
  }
}
