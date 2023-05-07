import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/fonts.dart';
import 'package:safe_nails/common/image_picker_service.dart';

class OldHomePage extends StatefulWidget {
  const OldHomePage({super.key});

  @override
  State<OldHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OldHomePage> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-6850065566204568/5619356631',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  List<String> unhealthyIngredientsFounded = [];

  @override
  void initState() {
    super.initState();
    myBanner.dispose();
    myBanner.load();
  }

  bool textScanning = false;
  XFile? imageFile;
  List<String> scannedText = [""];
  IconData? iconResult;

  @override
  Widget build(BuildContext context) {
    const int appColor = 0xfff97d5b1;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(100, 80),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color(appColor),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(CommonStrings.title, style:
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          CommonStrings.subTitle,
                          style:
                          TextStyle(
                            fontFamily: TTTravels.bold.familyName,
                            fontWeight: TTTravels.bold.weight,
                            color: const Color(appColor),
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
                                label: Text(CommonStrings.camera),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0)
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(appColor))
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
                                label: Text(CommonStrings.gallery),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(appColor))
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

  void getRecognisedText(XFile? image) async {
    final inputImage = InputImage.fromFilePath(image!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage);
    await textRecognizer.close();
    scannedText = [""];
    for (final TextBlock block in recognizedText.blocks) {
      for (final TextLine line in block.lines) {
        scannedText.add(line.text);
      }
    }
    textScanning = false;
    setState(() {});
  }

  bool? _getIngredientResult(List<String> scannedText) {
    for (final String ingredient in CommonStrings.unhealthyIngredients) {
      if (scannedText.contains(ingredient)) {
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
