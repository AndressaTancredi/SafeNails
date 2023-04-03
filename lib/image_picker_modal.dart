import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_picker_service.dart';

class ImagePickerModal extends StatefulWidget {
  const ImagePickerModal({Key? key}) : super(key: key);

  @override
  _ImagePickerModalState createState() => _ImagePickerModalState();
}

class _ImagePickerModalState extends State<ImagePickerModal> {
  final ImagePickerService _imagePickerService = ImagePickerService(MockImagePicker());
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await (source == ImageSource.camera
        ? _imagePickerService.pickImageFromCamera()
        : _imagePickerService.pickImageFromGallery());
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.black38,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tirar foto'),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Selecionar da galeria'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
