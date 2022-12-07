import 'package:flutter/material.dart';
import '../controller/form_controller.dart';

class PictureFormField extends StatelessWidget {
  FormController controller;

  PictureFormField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: controller.storedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: InkWell(
                      onTap: controller.takePictureGallery,
                      child: Image.file(
                        controller.storedImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: controller.takePictureGallery,
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
              onPressed: controller.takePictureCamera,
              icon: const Icon(
                Icons.camera_alt,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
