import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petty/core/models/vaccine_date_model.dart';

class VaccineCardDate extends StatelessWidget {
  VaccineCardDate({Key? key, required this.vaccineDate, required this.onRemove})
      : super(key: key);
  final VaccineModelDate vaccineDate;
  void Function(String) onRemove;

  bool dateExpiredFunction() {
    int dateLimit = int.parse(vaccineDate.dateLimit) * 30;
    if (DateTime.now().year >=
        vaccineDate.date.add(Duration(days: dateLimit)).year) {
      if (DateTime.now().month >=
          vaccineDate.date.add(Duration(days: dateLimit)).month) {
        if (DateTime.now().day >
            vaccineDate.date.add(Duration(days: dateLimit)).day) {
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
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
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
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  const Text(
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
              const SizedBox(
                width: 40,
              ),
              Column(
                children: [
                  const Text(
                    'Vencimento',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${DateFormat('dd/MM/y').format(
                    vaccineDate.date.add(Duration(days: dateLimit)),
                  )}'),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () => onRemove(vaccineDate.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ));
  }
}
