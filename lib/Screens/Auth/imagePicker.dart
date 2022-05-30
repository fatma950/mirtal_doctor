// ignore_for_file: file_names

import 'dart:io';

import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

openGallary(File? myImage) async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  myImage = File(image!.path);
}
