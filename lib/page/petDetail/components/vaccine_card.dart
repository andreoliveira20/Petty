import 'package:flutter/material.dart';
import 'package:petty/core/components/vaccine_card_date.dart';
import 'package:petty/core/components/vaccine_form_date.dart';
import 'package:petty/core/models/pet_model.dart';
import 'package:petty/core/models/vaccine_date_model.dart';
import 'package:petty/core/models/vaccine_model.dart';
import 'package:petty/core/controller/vaccine_date_list.dart';

class VaccineCard extends StatefulWidget {
  const VaccineCard({
    required this.pet,
    required this.vaccine,
    required this.removeVaccine,
  });
  final Pet pet;
  final Vaccine vaccine;
  final void Function(String) removeVaccine;

  @override
  State<VaccineCard> createState() => _VaccineCardState();
}

class _VaccineCardState extends State<VaccineCard>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;

  final vaccineDate = VaccineDateList();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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

  void removeVaccineDate(id) {
    setState(() {
      vaccineDate.deleteVaccineDate(id);
    });
  }

  void addVaccineDate(VaccineModelDate VaccineDate) {
    setState(() {
      vaccineDate.addVaccineDate(VaccineDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    openTransactionFormModal(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return VaccineFormDate(
              addVaccine: addVaccineDate,
              vaccine: widget.vaccine,
            );
          });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: Theme.of(context).cardColor,
            elevation: 5,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Row(
                children: [
                  const Icon(Icons.vaccines),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.vaccine.vaccinename,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => widget.removeVaccine(widget.vaccine.id),
                    icon: const Icon(
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
              duration: const Duration(milliseconds: 300),
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
                              ? const Center(
                                  child: const CircularProgressIndicator(),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: vaccineDate.vaccineDateCount,
                                    itemBuilder: (context, index) =>
                                        VaccineCardDate(
                                      vaccineDate:
                                          vaccineDate.vaccineDateList[index],
                                      onRemove: removeVaccineDate,
                                    ),
                                  ),
                                ),
                    ),
                    IconButton(
                      onPressed: () => openTransactionFormModal(context),
                      icon: const Icon(Icons.add),
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
