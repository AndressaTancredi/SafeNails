import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/common_strings.dart';

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
        throw Exception(CommonStrings.cropImageError);
      }
      return XFile(croppedFile.path);
    } catch (e) {
      if (kDebugMode) {
        print('${CommonStrings.cropImageError}: $e');
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
        throw Exception(CommonStrings.noImageSelected);
      }
      return cropSelectedImage(XFile(pickedFile.path));
    } catch (e) {
      if (kDebugMode) {
        print('${CommonStrings.noImageSelected}: $e');
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
        throw Exception(CommonStrings.noImageTook);
      }
      return cropSelectedImage(XFile(pickedFile.path));
    } catch (e) {
      if (kDebugMode) {
        print('${CommonStrings.noImageTook}: $e');
      }
      return null;
    }
  }
}
