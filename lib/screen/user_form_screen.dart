import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({Key? key}) : super(key: key);

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  var _storedImage;
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

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
    _submitForm() {
      Provider.of<Users>(context, listen: false).addUser(
        '1',
        userNameController.text,
        _storedImage,
      );
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Novo Usuario',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Criar Conta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
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
                              icon: const Icon(
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
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
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
                  horizontal: 10,
                ),
                child: TextField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
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
                  horizontal: 10,
                ),
                child: TextField(
                  controller: userPasswordController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                  ),
                  onPressed: () {},
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: _submitForm,
                      child: const Center(
                        child: Text(
                          'Criar Conta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Voce ja tem conta? Login'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
