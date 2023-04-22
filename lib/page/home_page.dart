import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import '../common/fonts.dart';
import '../image_picker_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-6850065566204568/5619356631',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  List<String> unhealthyIngredientsFounded = [];

  @override
  void initState() {
    super.initState();
    myBanner.dispose();
    myBanner.load();
  }

  bool textScanning = false;
  File? imageFile;
  List<String> scannedText = [""];
  IconData? iconResult;

  @override
  Widget build(BuildContext context) {
    int appAcolor = 0xfff97d5b1;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(100, 80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(appAcolor),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
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
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Verifique se o esmalte é seguro para a sua saúde e a do planeta.',
                          style:
                          TextStyle(
                            fontFamily: TTTravels.bold.familyName,
                            fontWeight: TTTravels.bold.weight,
                            color: Color(appAcolor),
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        if (textScanning) const CircularProgressIndicator(),
                        if (!textScanning && imageFile == null)
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius
                                .circular(8.0), color: Colors.grey[200]!),
                            width: 200,
                            height: 200,
                            child: Icon(Icons.image_search_outlined,
                              color: Colors.grey.shade100, size: 100.0,),
                            // color: Colors.grey[300]!,
                          ),
                        if (imageFile != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              File(imageFile!.path),
                              fit: BoxFit.fill,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: ElevatedButton.icon(
                                onPressed: () => _pickImage(ImageSource.camera),
                                icon: const Icon(Icons.camera_alt),
                                label: const Text('Câmera'),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0)
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(appAcolor))
                                ),
                              ),
                            ),
                            // const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    _pickImage(ImageSource.gallery),
                                icon: const Icon(Icons.photo_library),
                                label: const Text('Galeria'),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(appAcolor))
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _result(imageFile, scannedText),
                        // Text(
                        //   unhealthyIngredientsFounded.toString(),
                        //   style: const TextStyle(fontSize: 20),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 728, height: 90, child: AdWidget(ad: myBanner),
              ),
            ),
          )
        ],
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
      setState(() {});
    }
  }

  void getRecognisedText(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage);
    await textRecognizer.close();
    scannedText = [""];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText.add(line.text);
      }
    }
    textScanning = false;
    setState(() {});
  }

  List<String> scannedTextToUpperCase(scannedText){
    List<String> scannedTextUpperCase = [];
    for (String text in scannedText){
      scannedTextUpperCase.add(text.toUpperCase());
    }
    return scannedTextUpperCase;
  }

  bool? _getIngredientResult(List<String> scannedText) {
    final List<String> unhealthyIngredients = [
      "TOLUENO",
      "FORMALDEÍDO",
      "DIBUTILFTALATO (DBP)",
      "RESINA DE FORMALDEÍDO",
      "CÂNFORA",
      "XILENO",
      "ETIL TOSILAMIDA",
      "TRIFENILFOSFATO (TPHP)",
      "PARABENOS",
      "ACETONA",
      "SULFATO DE NÍQUEL",
      "SULFATO DE COBALTO",
      "ÓLEO MINERAL",
      "GLÚTEN",
      "PRODUTOS DERIVADOS DE ANIMAIS"
    ];

    List<String> scannedTextUpperCased = scannedTextToUpperCase(scannedText);

    for (String ingredient in unhealthyIngredients) {
      if (scannedTextUpperCased.contains(ingredient)) {
        unhealthyIngredientsFounded.add(ingredient);
      }
    }

    if (unhealthyIngredientsFounded.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

    Widget _result(imageFile, scannedText) {
      if (imageFile == null) {
        return const SizedBox.shrink();
      }
      if (_getIngredientResult(scannedText) == true) {
        return const Icon(
            Icons.do_not_touch, color: Colors.black26, size: 100.0);
      }
      if (_getIngredientResult(scannedText) == false) {
        return const Icon(Icons.check_circle, color: Colors.green, size: 100.0);
      }
      return const SizedBox.shrink();
    }
  }
