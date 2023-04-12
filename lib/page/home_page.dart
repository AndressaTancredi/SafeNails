import 'package:flutter/material.dart';
import '../common/fonts.dart';
import '../widget/bottom_sheet_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(child: const Text('Imagem'),
            onPressed: () {showBottomSheetInfo(context: context);},),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}