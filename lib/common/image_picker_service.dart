import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final _picker = ImagePicker();
  final _cropper = ImageCropper();

  ImagePickerService();

  Future<XFile?> cropSelectedImage(XFile file) async {
    try {
      final croppedFile = await _cropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
      );
      if (croppedFile == null) {
        throw Exception('Erro ao cortar a imagem.');
      }
      return XFile(croppedFile.path);
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao cortar a imagem: $e');
      }
      return null;
    }
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
      );
      if (pickedFile == null) {
        throw Exception('Nenhuma imagem selecionada');
      }
      return cropSelectedImage(XFile(pickedFile.path));
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao selecionar imagem da galeria: $e');
      }
      return null;
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 800,
        maxWidth: 800,
      );
      if (pickedFile == null) {
        throw Exception('Nenhuma imagem tirada');
      }
      return cropSelectedImage(XFile(pickedFile.path));
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao tirar foto: $e');
      }
      return null;
    }
  }
}
