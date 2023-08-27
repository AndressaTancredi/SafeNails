import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/firebase_utils.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/models/login_data.dart';
import 'package:safe_nails/ui/widgets/form_imput.dart';
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

  var dadosRecuperados = -1;
  final _formLogin = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuestionLink(
              question: "Não tem uma conta?",
              linkText: "Cadastre-se",
              routeOnPress: '/signup_page',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Login",
                style: title.copyWith(fontSize: 30),
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
                      label: "Email",
                      controller: emailController,
                      icon: Icons.email_outlined,
                      type: TextInputType.emailAddress,
                    ),
                    Input(
                      label: "Senha",
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
                  "Entrar",
                  style: TextStyle(fontSize: 20, color: AppColors.grey),
                ),
                onPressed: () => {
                  if (_formLogin.currentState!.validate())
                    {
                      handleAuth(context),
                    }
                },
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/reset_password_page');
              },
              child: Text(
                "Esqueceu a senha?",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF104F94),
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleAuth(BuildContext context) async {
    var login = LoginData(
      email: emailController.text,
      password: passwordController.text,
      deviceType: '2',
    );

    var auth = await FirebaseUtils.signIn(login.email, login.password);

    if (auth == "Success") {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed('/home_screen_page');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        toastAlert(
          type: Type.error,
          messages: {
            auth!.replaceAll("-", " "),
          },
        ),
      );
    }
  }
}
