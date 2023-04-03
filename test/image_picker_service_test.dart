// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:mockito/mockito.dart';
// import 'package:safe_nails/image_picker_service.dart';
//
//
// class MockImagePicker extends Mock implements ImagePicker {}
//
// class MockFile extends Mock implements File {}
//
// void main() {
//   group('ImagePickerService', () {
//     late ImagePickerService imagePickerService;
//     late MockImagePicker mockImagePicker;
//
//     setUp(() {
//       mockImagePicker = MockImagePicker();
//       imagePickerService = ImagePickerService(mockImagePicker);
//     });
//
//     test('pickImageFromGallery returns null when no image is selected', () async {
//       // Setup
//       when(mockImagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxHeight: 800,
//         maxWidth: 800,
//         imageQuality: 80,
//       )).thenAnswer((_) => Future.value(null));
//
//       // Action
//       final result = await imagePickerService.pickImageFromGallery();
//
//       // Verify
//       expect(result, isNull);
//     });
//
//     test('pickImageFromGallery returns a cropped file when an image is selected', () async {
//       // Setup
//       final mockFile = MockFile();
//       when(mockFile.path).thenReturn('path/to/image');
//       when(mockImagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxHeight: 800,
//         maxWidth: 800,
//         imageQuality: 80,
//       )).thenAnswer((_) => Future.value(mockFile));
//       final mockCroppedFile = MockFile();
//       when(mockCroppedFile.path).thenReturn('path/to/cropped/image');
//       when(ImageCropper().cropImage(
//         sourcePath: 'path/to/image',
//         maxHeight: 800,
//         maxWidth: 800,
//         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//         compressQuality: 80,
//         androidUiSettings: const AndroidUiSettings(
//           toolbarTitle: 'Editar imagem',
//           toolbarColor: Colors.blue,
//           toolbarWidgetColor: Colors.white,
//           hideBottomControls: true,
//           lockAspectRatio: true,
//         ),
//       )).thenAnswer((_) => Future.value(mockCroppedFile));
//
//       // Action
//       final result = await imagePickerService.pickImageFromGallery();
//
//       // Verify
//       verify(mockImagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxHeight: 800,
//         maxWidth: 800,
//         imageQuality: 80,
//       ));
//       verify(ImageCropper().cropImage(
//         sourcePath: 'path/to/image',
//         maxHeight: 800,
//         maxWidth: 800,
//         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//         compressQuality: 80,
//         androidUiSettings: const AndroidUiSettings(
//           toolbarTitle: 'Editar imagem',
//           toolbarColor: Colors.blue,
//           toolbarWidgetColor: Colors.white,
//           hideBottomControls: true,
//           lockAspectRatio: true,
//         ),
//       ));
//       expect(result, mockCroppedFile);
//     });
//
//     test('pickImageFromCamera returns null when no image is taken', () async {
//       // Setup
//       when(mockImagePicker.pickImage(
//           source: ImageSource.camera,
//           maxHeight: 800,
//           maxWidth: 800,
//           imageQuality: 80
