import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

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
  TextStyle get linkTextStyle => sl<TextStyles>().linkText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.ice,
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
              style: linkTextStyle,
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
