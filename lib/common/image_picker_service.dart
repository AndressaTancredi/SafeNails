import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final _picker = ImagePicker();

  ImagePickerService();

  Future<XFile?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        // imageQuality: 80,
      );
      if (pickedFile == null) throw Exception('Nenhuma imagem selecionada');
      return pickedFile;
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
        // imageQuality: 80,
      );
      if (pickedFile == null) throw Exception('Nenhuma imagem tirada');
      return pickedFile;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao tirar foto: $e');
      }
      return null;
    }
  }
}
