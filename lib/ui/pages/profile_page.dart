import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/firebase_utils.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Icon(
                  Icons.account_circle,
                  color: AppColors.pink,
                  size: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  "Meu Perfil",
                  style: title.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                title: Text(
                  'Deletar conta',
                  style: bodyDescription,
                ),
                textColor: AppColors.grey,
                trailing: Icon(
                  Icons.chevron_right,
                  color: AppColors.regularBlack.withOpacity(0.2),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () async {
                  await FirebaseUtils.deleteUser().then((value) =>
                      Navigator.of(context).pushNamed('/login_page'));
                },
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Sair',
                  style: bodyDescription,
                ),
                textColor: AppColors.grey,
                trailing: Icon(
                  Icons.chevron_right,
                  color: AppColors.regularBlack.withOpacity(0.2),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () async {
                  await FirebaseUtils.signOut().then((value) =>
                      Navigator.of(context).pushNamed('/login_page'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
