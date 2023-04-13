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
        title: Text("Nails", style:
      TextStyle(
      fontFamily: TTTravels.bold.familyName,
        fontWeight: TTTravels.bold.weight,
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 24,
      ),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                        child: Text(
                          'Adicione uma foto para entender se esse esmalte é seguro ou não para a sua saúde e a do planeta.',
                          style: TextStyle(fontSize: 20),
            ),
                      ),
                      if (textScanning) const CircularProgressIndicator(),
                      if (!textScanning && imageFile == null)
                        Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                      if (imageFile != null)
                        Image.file(
                          File(imageFile!.path),
                          fit: BoxFit.fill,
                          width: 300,
                          height: 300,
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () => _pickImage(ImageSource.camera),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Câmera'),
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () => _pickImage(ImageSource.gallery),
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Galeria'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      if (_getIngredientResult(scannedText))
                        const Icon(Icons.do_not_touch, color: Colors.black, size: 100.0,),
                      if (!_getIngredientResult(scannedText))
                        const Icon(Icons.check_circle, color: Colors.green, size: 100.0,),
                      // Text(
                      //   scannedText,
                      //   style: const TextStyle(fontSize: 20),
                      // ),
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

  bool _getIngredientResult(String scannedText) {
    final List<String> unhealthyIngredients = [
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
     } if (!scannedText.contains(ingredient)){
       return false;
     }
   }
    return false;
    }
  }
