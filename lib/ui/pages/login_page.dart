import 'package:flutter/material.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/firebase_utils.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/models/login_data.dart';
import 'package:safe_nails/ui/widgets/form_input.dart';
import 'package:safe_nails/ui/widgets/question_link.dart';
import 'package:safe_nails/ui/widgets/toast_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;
  TextStyle get linkText => sl<TextStyles>().linkText;
  TextStyle get buttonText => sl<TextStyles>().buttonText;

  final _formLogin = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sl<Analytics>().onScreenView(AnalyticsEventTags.login_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuestionLink(
                question: CommonStrings.haveNotAccount,
                linkText: CommonStrings.register,
                routeOnPress: '/signup_page',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  CommonStrings.login,
                  style: title,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Form(
                  key: _formLogin,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      Input(
                        label: CommonStrings.email,
                        controller: emailController,
                        icon: Icons.email_outlined,
                        type: TextInputType.emailAddress,
                      ),
                      Input(
                        label: CommonStrings.password,
                        controller: passwordController,
                        icon: Icons.lock_open_outlined,
                        isPassword: true,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 50,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.pink),
                  child: Text(
                    CommonStrings.enter,
                    style: buttonText.copyWith(color: Colors.white),
                  ),
                  onPressed: () => {
                    if (_formLogin.currentState!.validate())
                      {
                        handleAuth(context),
                      }
                  },
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/reset_password_page');
                },
                child: Text(
                  CommonStrings.forgotPassword,
                  style: linkText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleAuth(BuildContext context) async {
    var login = LoginData(
      email: emailController.text,
      password: passwordController.text,
    );

    var auth = await FirebaseUtils.signIn(login.email, login.password);

    if (auth == CommonStrings.success) {
      Navigator.of(context).pushNamed('/home_screen_page');
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
