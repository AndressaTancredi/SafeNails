import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/firebase_utils.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/preferences.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/models/user_data.dart';
import 'package:safe_nails/ui/pages/terms_and_conditions_page.dart';
import 'package:safe_nails/ui/widgets/form_input.dart';
import 'package:safe_nails/ui/widgets/question_link.dart';
import 'package:safe_nails/ui/widgets/toast_alert.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/sign_up';

  const SignUpPage({super.key});
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;
  TextStyle get linkText => sl<TextStyles>().linkText;
  TextStyle get buttonText => sl<TextStyles>().buttonText;

  final _formSignUp = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isFormValid = false;
  bool _isTermsAccepted = false;

  @override
  void initState() {
    super.initState();
    sl<Analytics>().onScreenView(AnalyticsEventTags.signup_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 45),
                QuestionLink(
                    question: CommonStrings.haveAccount,
                    linkText: CommonStrings.login,
                    routeOnPress: '/login_page'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    CommonStrings.signupTitle,
                    style: title.copyWith(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Form(
                    key: _formSignUp,
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: () {
                      setState(() {
                        _isFormValid = _formSignUp.currentState!.validate();
                      });
                    },
                    child: Column(
                      children: [
                        Input(
                          label: CommonStrings.name,
                          controller: nameController,
                          icon: Icons.manage_accounts_outlined,
                        ),
                        Input(
                          label: CommonStrings.email,
                          controller: emailController,
                          icon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                        ),
                        Input(
                          label: CommonStrings.password,
                          controller: passwordController,
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                        ),
                        Input(
                          label: CommonStrings.confirmPassword,
                          controller: confirmPasswordController,
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          isConfirmationPassword: true,
                          confirmPasswordValidator: (value) {
                            if (value != passwordController.text) {
                              return CommonStrings.matchPass;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Checkbox(
                              value: _isTermsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _isTermsAccepted = value!;
                                });
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TermsAndConditionsPage(),
                                ));
                              },
                              child: Text(
                                CommonStrings.termsAndConditionsAgreement,
                                style: linkText.copyWith(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.pink),
                            child: Text(
                              CommonStrings.toRegister,
                              style: buttonText.copyWith(color: Colors.white),
                            ),
                            onPressed: _isFormValid && _isTermsAccepted
                                ? () {
                                    storeUserData();
                                    handleSingUp(context);
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void storeUserData() async {
    User user1 = new User(
        nameController.text, emailController.text, passwordController.text);
    String user = jsonEncode(user1);
    await Preferences().storeUserData('userdata', user);
  }

  handleSingUp(BuildContext context) async {
    var auth = await FirebaseUtils.createUser(
        nameController.text, emailController.text, passwordController.text);

    if (auth == CommonStrings.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        toastAlert(
          type: ToastType.success,
          messages: [
            auth!.replaceAll("-", " "),
          ],
        ),
      );
      Navigator.of(context).pushNamed('/login_page');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        toastAlert(
          type: ToastType.error,
          messages: [
            auth!.replaceAll("-", " "),
          ],
        ),
      );
    }
  }
}
