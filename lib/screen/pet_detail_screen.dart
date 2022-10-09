import 'package:flutter/material.dart';
import 'package:petty/components/banner_pet.dart';
import 'package:petty/components/vaccine_card.dart';
import 'package:petty/components/vaccine_form.dart';
import 'package:petty/models/pet_model.dart';
import 'package:petty/provider/vaccine_list.dart';
import 'package:petty/models/vaccine_model.dart';
import 'package:provider/provider.dart';

class PetDetailScreen extends StatefulWidget {
  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Pet pet = ModalRoute.of(context)!.settings.arguments as Pet;
    final provider = Provider.of<VaccineList>(context);

    _addVaccine(Vaccine vaccine) {
      setState(() {
        provider.addVaccine(vaccine);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vacina adicionada com sucesso'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    openTransactionFormModal(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return VaccineForm(
              addVaccine: _addVaccine,
              pet: pet,
            );
          });
    }

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        child: Column(
          children: [
            BannerPet(pet: pet),
            FutureBuilder(
              future: provider.loadVaccine(pet),
              builder: (BuildContext context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: provider.vaccineCount,
                            itemBuilder: (context, index) => VaccineCard(
                              pet: pet,
                              vaccine: provider.vaccineList[index],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 24, 16, 64),
        onPressed: () => openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
