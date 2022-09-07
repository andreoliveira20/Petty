import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petty/provider/pet_list.dart';
import 'package:petty/utils/app_routes.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PetFormScreen extends StatefulWidget {
  const PetFormScreen({Key? key}) : super(key: key);

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  List<bool> isSelected = [false, false];

  final namePetController = TextEditingController();

  final breedController = TextEditingController();

  final ageController = TextEditingController();

  final weightController = TextEditingController();

  var _storedImage;

  _takePictureCamera() async {
    final ImagePicker _picker = ImagePicker();
    var imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  _takePictureGallery() async {
    final ImagePicker _picker = ImagePicker();
    var imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetList>(context);
    _submitForm() {
      if (namePetController.text == '') {
        return;
      }
      if (breedController.text == '') {
        return;
      }
      if (ageController.text == '') {
        return;
      }
      if (weightController.text == '') {
        return;
      } else {
        provider.addPets(
          namePetController.text,
          ageController.text,
          breedController.text,
          isSelected[0] ? 'Macho' : 'Femea',
          _storedImage,
          weightController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pet adicionado com sucesso'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 16, 64),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Adicionar Pet',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: _storedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: InkWell(
                              onTap: _takePictureGallery,
                              child: Image.file(
                                _storedImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: _takePictureGallery,
                            icon: Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
                    radius: 60,
                  ),
                  Positioned(
                    right: -12,
                    bottom: 0,
                    child: IconButton(
                      onPressed: _takePictureCamera,
                      icon: Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                Text(
                  'Tipo',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 90,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelected[0] = true;
                        isSelected[1] = false;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected[0] ? Colors.blue[900] : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Macho',
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected[0] ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelected[0] = false;
                        isSelected[1] = true;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected[1] ? Colors.blue[900] : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Femea',
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected[1] ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                controller: namePetController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                controller: breedController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Raca',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Idade',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Peso',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: _submitForm,
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 24, 16, 64),
                  ),
                  child: Center(
                    child: Text(
                      'Adicionar Pet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
