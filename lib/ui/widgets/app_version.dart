import 'package:flutter/cupertino.dart';
import 'package:safe_nails/common/app_metadata.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class AppVersion extends StatelessWidget {
  TextStyle get textVersionStyle =>
      sl<TextStyles>().resultBody.copyWith(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(CommonStrings.appVersion, style: textVersionStyle),
        FutureBuilder<String>(
            future: sl<AppMetadata>().versionNumber(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text('APP v${snapshot.data}', style: textVersionStyle);
              } else {
                return Container();
              }
            })
      ],
    );
  }
}
