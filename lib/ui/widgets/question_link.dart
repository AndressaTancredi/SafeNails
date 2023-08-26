import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class QuestionLink extends StatelessWidget {
  const QuestionLink({
    super.key,
    required this.question,
    required this.linkText,
    required this.routeOnPress,
  });

  final String question;
  final String linkText;
  final String routeOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF2F4F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question),
          const SizedBox(
            width: 6,
          ),
          RichText(
            text: TextSpan(
              text: linkText,
              style: const TextStyle(
                color: Color(0xFF104F94),
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(routeOnPress);
                },
            ),
          ),
        ],
      ),
    );
  }
}
