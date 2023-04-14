import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../common/fonts.dart';
import '../image_picker_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool textScanning = false;
  File? imageFile;
  String scannedText = "";
  IconData? iconResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[300],
        title: Center(
          child: Text("Safe Nails", style:
      TextStyle(
      fontFamily: TTTravels.bold.familyName,
          fontWeight: TTTravels.bold.weight,
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontSize: 24,
      ),),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Verifique se o esmalte é seguro ou não para a sua saúde e a do planeta.',
                        style:
                        TextStyle(
                          fontFamily: TTTravels.bold.familyName,
                          fontWeight: TTTravels.bold.weight,
                          color: Colors.blueGrey[300],
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        )
                      ),
                      const SizedBox(height: 30),
                      if (textScanning) const CircularProgressIndicator(),
                      if (!textScanning && imageFile == null)
                      Container(
                        decoration: BoxDecoration( borderRadius:  BorderRadius.circular(8.0), color: Colors.grey[300]!),
                        width: 200,
                        height: 200,
                        child: const Icon(Icons.image_search_outlined, color: Colors.grey, size: 100.0,),
                        // color: Colors.grey[300]!,
                      ),
                      if (imageFile != null)
                        Image.file(
                          File(imageFile!.path),
                          fit: BoxFit.fill,
                          width: 250,
                          height: 250,
                        ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () => _pickImage(ImageSource.camera),
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('Câmera'),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
                              ),
                            ),
                          ),
                          // const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.photo_library),
                              label: const Text('Galeria'),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _result(imageFile, scannedText),
                      Text(
                        scannedText,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  final ImagePickerService _imagePickerService = ImagePickerService();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await (source == ImageSource.camera
          ? _imagePickerService.pickImageFromCamera()
          : _imagePickerService.pickImageFromGallery());

      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  bool? _getIngredientResult(String scannedText) {
    final List<String> unhealthyIngredients = [
      "ter",
      "Tolueno",
      "Formaldeído",
      "Dibutilftalato (DBP)",
      "Resina de formaldeído",
      "Cânfora",
      "Xileno",
      "Etil tosilamida",
      "Trifenilfosfato (TPHP)",
      "Parabenos",
      "Acetona",
      "Sulfato de níquel",
      "Sulfato de cobalto",
      "Óleo mineral",
      "Glúten",
      "Produtos derivados de animais"
    ];

   for (var ingredient in unhealthyIngredients) {
     if (scannedText.contains(ingredient)) {
       return true;
     } else {
       return false;
     }
   }
   return null;
    }

    Widget _result(imageFile, scannedText) {
      if (imageFile == null) {
        return const SizedBox.shrink();
      }
      if (_getIngredientResult(scannedText) == true) {
        return const Icon(Icons.do_not_touch, color: Colors.black, size: 100.0);
      }
      if (_getIngredientResult(scannedText) == false) {
        return const Icon(Icons.check_circle, color: Colors.green, size: 100.0);
      }
      return const SizedBox.shrink();
    }
  }
