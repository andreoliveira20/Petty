import 'package:flutter/material.dart';
import 'package:petty/components/vaccine_card_date.dart';
import 'package:petty/components/vaccine_form_date.dart';
import 'package:petty/models/pet_model.dart';
import 'package:petty/models/vaccine_model.dart';
import 'package:petty/provider/vaccine_date_list.dart';
import 'package:petty/provider/vaccine_list.dart';
import 'package:provider/provider.dart';

class VaccineCard extends StatefulWidget {
  VaccineCard({
    required this.pet,
    required this.vaccine,
  });
  final Pet pet;
  final Vaccine vaccine;

  @override
  State<VaccineCard> createState() => _VaccineCardState();
}

class _VaccineCardState extends State<VaccineCard>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void vaccineSelectedFunction() {
    setState(() {
      isSelected = !isSelected;
      isSelected ? _controller!.forward() : _controller!.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VaccineList>(context);
    final vaccineDate = Provider.of<VaccineDateList>(context);
    final count = vaccineDate.vaccineDateCount;

    openTransactionFormModal(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return VaccineFormDate(
              addVaccine: vaccineDate.addVaccineDate,
              vaccine: widget.vaccine,
            );
          });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Icon(Icons.vaccines),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.vaccine.vaccinename,
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => provider.deleteVaccine(widget.vaccine.id),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: vaccineSelectedFunction,
                    icon: Icon(
                      isSelected ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              constraints: BoxConstraints(
                minHeight: isSelected ? 60 : 0,
                maxHeight: isSelected ? 200 : 0,
              ),
              curve: Curves.linear,
              child: FadeTransition(
                opacity: _opacityAnimation!,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: vaccineDate.loadVaccineDate(widget.vaccine),
                      builder: (BuildContext context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: vaccineDate.vaccineDateCount,
                                    itemBuilder: (context, index) =>
                                        VaccineCardDate(
                                      vaccineDate:
                                          vaccineDate.vaccineDateList[index],
                                      onRemove: vaccineDate.deleteVaccineDate,
                                    ),
                                  ),
                                ),
                    ),
                    IconButton(
                      onPressed: () => openTransactionFormModal(context),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
