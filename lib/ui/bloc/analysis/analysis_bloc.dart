import 'package:bloc/bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/image_picker_service.dart';
import 'package:safe_nails/data/ingredients_data.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  List<String> scannedText = [];
  List<String> unhealthyIngredientsFounded = [];
  XFile? pickedImage;

  AnalysisBloc() : super(AnalysisEmptyState()) {
    on<NewImageEvent>(_newPolishNailsPhoto);
    on<ClearResultEvent>(_clearResults);
  }

  void _clearResults(ClearResultEvent event, Emitter emit) {
    scannedText.clear();
    unhealthyIngredientsFounded.clear();
    pickedImage = null;
    emit(AnalysisEmptyState());
  }

  Future<void> _newPolishNailsPhoto(NewImageEvent event, Emitter emit) async {
    final ImagePickerService imagePickerService = ImagePickerService();

    final pickedImage = await (event.cameraSource == true
        ? imagePickerService.pickImageFromCamera()
        : imagePickerService.pickImageFromGallery());

    if (pickedImage != null) {
      emit(AnalysisLoadingState());
    }

    final inputImage = InputImage.fromFilePath(pickedImage!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    for (final TextBlock block in recognizedText.blocks) {
      for (final TextLine line in block.lines) {
        for (final TextElement word in line.elements) {
          scannedText.add(word.text);
        }
      }
    }
    // flutter: [INGREDIENTES:, BUTYL, ACETATE;, ETHYLACETATE;, NITROCELLULOSE;, TOSYLAMIDE/FORMALDEHYDE, RESIN;, ISOPROPYLALCOHOL;, DIISOBUTYLADIPATE;, CAMPHOR;, SUCROSE, ACETATE, ISOBUTYRATE;, TOSYLAMIDE/EPOXY, RESIN;, STEARALKONIUM, HECTORITE;, ACETYL, TRIBUTYL, CITRATE;, PANTHENOL;2-METHYLPROPANAL;, CALCIUM, PANTOTHENATE;, POLYPERFLUOROMETHYLISOPROPYL, ETHER;, DIAMOND, POWDER., PUEDE, CONTENER:, 0CTOCRYLENE;, BENZOPHENONE-3;, ALCOHOL;, MICA/CI, 77019;, CI, 77891;, CI, 77000;, CI, 15850;, C1, 42090;, C, 77491;, C, 77492;, CI, 77499;, CI, 77510;, CI, 19140:, CALCIUM, ALUMINUM, BOROSILICATE;, SILICA;, CI, 15880;, OXIDIZED, POLYETHYLENE,, CI, 77163.]
    // flutter: [Camphor, Formaldehyde]

    String removeSpecialCharacters(String text) {
      return text
          .replaceAll(RegExp(r'[áàãâä]'), 'a')
          .replaceAll(RegExp(r'[éèêë]'), 'e')
          .replaceAll(RegExp(r'[íìîï]'), 'i')
          .replaceAll(RegExp(r'[óòõôö]'), 'o')
          .replaceAll(RegExp(r'[úùûü]'), 'u')
          .replaceAll(RegExp(r'[ç]'), 'c')
          .replaceAll(RegExp(r'[,;.:)(ˆ*@!/|#?]'), '');
    }

    bool hasUnhealthyIngredients() {
      for (final String ingredient in IngredientsData.unhealthyIngredients) {
        for (final String scannedWord in scannedText) {
          final cleanedScannedWord =
              removeSpecialCharacters(scannedWord).toUpperCase();
          print(cleanedScannedWord);

          if (cleanedScannedWord.contains(ingredient.toUpperCase())) {
            unhealthyIngredientsFounded.add(ingredient);
          }
        }
      }

      if (unhealthyIngredientsFounded.isEmpty) {
        return true;
      } else {
        return false;
      }
    }

    final bool result = hasUnhealthyIngredients();

    if (scannedText.isEmpty) {
      emit(NoWordState(noWord: true, photo: pickedImage));
    } else {
      emit(ResultState(
          photo: pickedImage,
          isSafe: result,
          unhealthyIngredientsFounded: unhealthyIngredientsFounded));
    }
  }
}
