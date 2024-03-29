import 'package:flutter/material.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/firebase_utils.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/widgets/form_input.dart';
import 'package:safe_nails/ui/widgets/toast_alert.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  final _formChangePass = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sl<Analytics>().onScreenView(AnalyticsEventTags.reset_pass_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Icon(
                    Icons.lock_reset_sharp,
                    color: AppColors.pink.withOpacity(0.5),
                    size: 130,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    CommonStrings.changePassword,
                    style: title,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  CommonStrings.registeredEmailInfo,
                  style: bodyDescription,
                ),
                const SizedBox(height: 25),
                Container(
                  child: Form(
                    key: _formChangePass,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        Input(
                          label: CommonStrings.email,
                          controller: emailController,
                          icon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  CommonStrings.linkSendToChangePass,
                  style: bodyDescription,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pink),
                    child: Text(
                      CommonStrings.send,
                      style: TextStyle(fontSize: 20, color: AppColors.grey),
                    ),
                    onPressed: () => {handleResetPassword(context)},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleResetPassword(BuildContext context) async {
    var resetPass =
        await FirebaseUtils.resetPassword(emailController.value.text);

    if (resetPass == CommonStrings.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        toastAlert(
          type: ToastType.success,
          messages: [
            resetPass!.replaceAll("-", " "),
          ],
        ),
      );
      Navigator.of(context).pushNamed('/login_page');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        toastAlert(
          type: ToastType.error,
          messages: [
            resetPass!.replaceAll("-", " "),
          ],
        ),
      );
    }
  }
}
