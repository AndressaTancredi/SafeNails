import 'package:bloc/bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/image_picker_service.dart';
import 'package:safe_nails/ui/bloc/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc() : super(GetImageAnalysisState()) {
    on<GetImageEvent>(_takePicture);
  }

  Future<void> _takePicture(GetImageEvent event, Emitter emit) async {
    final ImagePickerService imagePickerService = ImagePickerService();
    XFile? imageFile;
    final List<String> scannedText = [""];

      final pickedImage = await (event.source == ImageSource.camera
          ? imagePickerService.pickImageFromCamera()
          : imagePickerService.pickImageFromGallery());

      if (pickedImage != null) {
        imageFile = pickedImage;
      }


    void getRecognisedText(XFile? imageFile) async {
      final inputImage = InputImage.fromFilePath(imageFile!.path);
      final textRecognizer = TextRecognizer();
      final RecognizedText recognizedText = await textRecognizer.processImage(
          inputImage);
      await textRecognizer.close();
      for (final TextBlock block in recognizedText.blocks) {
        for (final TextLine line in block.lines) {
          scannedText.add(line.text);
        }
      }
    }

  }
}
