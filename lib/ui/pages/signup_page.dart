// import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/widgets/form_imput.dart';
import 'package:safe_nails/ui/widgets/question_link.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/sign_up';

  const SignUpPage({super.key});
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  final _formSignUp = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              QuestionLink(
                  question: "Já tem uma conta?",
                  linkText: 'Login',
                  routeOnPress: '/login_page'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  "Cadastro",
                  style: title.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Form(
                  key: _formSignUp,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      Input(
                        label: 'Nome',
                        controller: nameController,
                        icon: Icons.manage_accounts_outlined,
                      ),
                      Input(
                        label: 'Email',
                        controller: emailController,
                        icon: Icons.email_outlined,
                        type: TextInputType.emailAddress,
                      ),
                      Input(
                        label: 'Senha',
                        controller: passwordController,
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                      ),
                      Input(
                        label: 'Confirmar a senha',
                        controller: confirmPasswordController,
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.pink),
                          child: Text(
                            'Cadastrar',
                            style:
                                TextStyle(fontSize: 20, color: AppColors.grey),
                          ),
                          onPressed: () => {
                            Navigator.of(context).pushNamed('/login_page'),
                            // handleSingUp(context),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // js.context.callMethod(
                  //     'open', ['https://stackoverflow.com/questions/ask']);
                  // _launchURL();
                },
                child: Text(
                  'Termos e Condições',
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
      ),
    );
  }

  // _launchURL() async {
  //   const url =
  //       'https://codecloud-pp.blogspot.com/2023/04/politica-de-privacidade.html';
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

// handleSingUp(BuildContext context) async {
//   var data = SignUpData(
//     name: nameController.text,
//     email: emailController.text,
//     password: passwordController.text,
//     deviceToken: await FirebaseUtils.getFirebaseToken(),
//     deviceType: '2',
//   );
//
//   var auth =
//   await FirebaseUtils.createUser(data.name, data.email, data.password);
//
//   if (auth == "Success") {
//     FirebaseUtils.sendAnalyticsEvents().logSignUp(signUpMethod: "email");
//     // ignore: use_build_context_synchronously
//     handleNavigation(context, '/login', true);
//   } else {
//     // ignore: use_build_context_synchronously
//     ScaffoldMessenger.of(context).showSnackBar(
//       toastAlert(type: Type.error, messages: {auth!.replaceAll("-", " ")}),
//     );
//   }
// }
}
