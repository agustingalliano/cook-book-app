import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnImageSelected = Function(XFile imageFile);

class ImagePickerWidget extends StatelessWidget {
  File imageFile;
  OnImageSelected onImageSelected;

  ImagePickerWidget({required this.imageFile, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan[300] as Color,
              Colors.cyan[800] as Color,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          image: imageFile != null
              ? DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover)
              : null),
      child: IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: () {
          _showPickerOptions(context);
        },
        color: Colors.white,
        iconSize: 90,
      ),
    );
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _showPickerImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Galeria"),
              onTap: () {
                Navigator.pop(context);
                _showPickerImage(context, ImageSource.gallery);
              },
            )
          ],
        );
    });
  }

  void _showPickerImage(BuildContext context, source) async{
    var image = await ImagePicker().pickImage(source: source) as XFile;
    onImageSelected(image);
  }
}
