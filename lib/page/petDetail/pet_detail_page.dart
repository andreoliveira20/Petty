import 'package:flutter/material.dart';
import 'package:petty/core/models/pet_model.dart';
import 'package:petty/core/models/vaccine_model.dart';
import 'package:petty/page/petDetail/components/banner_pet.dart';
import 'package:petty/page/petDetail/components/vaccine_card.dart';
import 'package:petty/page/petDetail/components/vaccine_form.dart';
import 'package:petty/page/petDetail/controller/pet_detail_controller.dart';

class PetDetailPage extends StatefulWidget {
  const PetDetailPage({Key? key}) : super(key: key);

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Pet pet = ModalRoute.of(context)!.settings.arguments as Pet;
    final vaccineList = VaccineList();

    _addVaccine(Vaccine vaccine) {
      setState(() {
        vaccineList.addVaccine(vaccine);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vacina adicionada com sucesso'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    _removeVaccine(id) {
      setState(() {
        vaccineList.deleteVaccine(id);
      });
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
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            BannerPet(pet: pet),
            FutureBuilder(
              future: vaccineList.loadVaccine(pet),
              builder: (BuildContext context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: vaccineList.vaccineCount,
                            itemBuilder: (context, index) => VaccineCard(
                              pet: pet,
                              vaccine: vaccineList.vaccineList[index],
                              removeVaccine: _removeVaccine,
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 24, 16, 64),
        onPressed: () => openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
