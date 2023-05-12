import 'package:flutter/material.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final String routePath;
  const Button({super.key, required this.buttonText, required this.routePath});

  TextStyle get button => sl<TextStyles>().buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        minimumSize: const Size(180, 45),
      ),
      onPressed: () => Navigator.of(context).pushNamed(routePath),
      child: Text(buttonText,
        style: button,
      ),
    );
  }
}
