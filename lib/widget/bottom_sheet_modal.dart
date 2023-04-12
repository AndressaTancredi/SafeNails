import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../image_picker_service.dart';

final ImagePickerService _imagePickerService = ImagePickerService();

Future<void> _pickImage(ImageSource source) async {
  final pickedFile = await (source == ImageSource.camera
      ? _imagePickerService.pickImageFromCamera()
      : _imagePickerService.pickImageFromGallery());
}

const _bottomSheetRadius = Radius.circular(8);

void showBottomSheetInfo(
    { required BuildContext context,
      bool isScrollControlled = false
    }
  )
  {
  final mainWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 32),
      Padding(
        padding: const EdgeInsets.only(left: 36, right: 24),
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
  );
  
  Widget? scrollControlledWidget;
  
  if (isScrollControlled) {
    scrollControlledWidget = SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: mainWidget,
    );
  }
  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.6,
        child: scrollControlledWidget ?? mainWidget,
      );
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: _bottomSheetRadius,
        topRight: _bottomSheetRadius,
      ),
    ),
  );
}