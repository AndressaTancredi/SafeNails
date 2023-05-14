import 'package:bloc/bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/image_picker_service.dart';
import 'package:safe_nails/data/datasources/ingredients_data.dart';
import 'package:safe_nails/ui/bloc/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  List<String> scannedText = [];
  List<String> unhealthyIngredientsFounded = [];
  XFile? pickedImage;

  AnalysisBloc() : super(AnalysisEmptyState()) {
    on<NewImageEvent>(_newPhoto);
    on<ClearResultEvent>(_clearResults);
  }

  void _clearResults(ClearResultEvent event, Emitter emit) {
    scannedText.clear();
    unhealthyIngredientsFounded.clear();
    pickedImage = null;
    emit(AnalysisEmptyState());
  }

  Future<void> _newPhoto(NewImageEvent event, Emitter emit) async {
    final ImagePickerService imagePickerService = ImagePickerService();

    final pickedImage = await (event.cameraSource == true
        ? imagePickerService.pickImageFromCamera()
        : imagePickerService.pickImageFromGallery());

    emit(AnalysisLoadingState());

    final inputImage = InputImage.fromFilePath(pickedImage!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    for (final TextBlock block in recognizedText.blocks) {
      for (final TextLine line in block.lines) {
        scannedText.add(line.text);
      }
    }

    bool getIngredientResult() {
      for (final String ingredient in IngredientsData.unhealthyIngredients) {
        if (scannedText.contains(ingredient)) {
          unhealthyIngredientsFounded.add(ingredient);
        }
      }

      if (unhealthyIngredientsFounded.isEmpty) {
        return true;
      } else {
        return false;
      }
    }

    final bool result = getIngredientResult();

    emit(ResultState(photo: pickedImage, isSafe: result));
  }
}
