import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickerService {
  final _picker = ImagePicker();

  ImagePickerService();

  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 80,
      );
      if (pickedFile == null) throw Exception('Nenhuma imagem selecionada');
      final croppedFile = await _cropImage(File(pickedFile.path));
      return croppedFile;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao selecionar imagem da galeria: $e');
      }
      return null;
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 80,
      );
      if (pickedFile == null) throw Exception('Nenhuma imagem tirada');
      final croppedFile = await _cropImage(File(pickedFile.path));
      return croppedFile;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao tirar foto: $e');
      }
      return null;
    }
  }

  Future<File?> _cropImage(File file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      maxHeight: 800,
      maxWidth: 800,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 80,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar imagem',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
        lockAspectRatio: true,
      ),
    );
    if (croppedFile == null) throw Exception('Erro ao recortar imagem');
    return croppedFile;
  }
}
