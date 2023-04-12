import 'package:flutter/material.dart';

import '../image_picker_modal.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nails"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(child: Text('Imagem'),
            onPressed: () {ImagePickerModal();},),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}