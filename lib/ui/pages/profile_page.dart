import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/preferences.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/profile/profile_bloc.dart';
import 'package:safe_nails/ui/bloc/profile/profile_event.dart';
import 'package:safe_nails/ui/bloc/profile/profile_state.dart';
import 'package:safe_nails/ui/widgets/loading.dart';

import '../../common/firebase_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileBloc = sl<ProfileBloc>();
  TextStyle get titleStyle => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().resultBody;
  TextStyle get button => sl<TextStyles>().buttonText;

  Future<Map<String, dynamic>> _getUserData() async {
    return await Preferences().getUserData();
  }

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<ProfileBloc, ProfileState>(
                  bloc: profileBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfileLoadingState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Loading(),
                      );
                    }
                    if (state is ProfileEmptyState) {
                      return Column(
                        children: [
                          const SizedBox(height: 30),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                profileBloc.add(NewPhotoEvent());
                              },
                              child: SvgPicture.asset(
                                getPhotoPah(),
                                alignment: Alignment.topLeft,
                                height: 130,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      );
                    }
                    if (state is ProfileLoadedState) {
                      return Column(
                        children: [
                          const SizedBox(height: 30),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                profileBloc.add(NewPhotoEvent());
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200.0),
                                child: Image.file(
                                  File(profileBloc.photoPath),
                                  height: 180.0,
                                  width: 180.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future: _getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final userData = snapshot.data!;
                      final userName = userData['name'];
                      final userEmail = userData['email'];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              userName ?? '',
                              style: bodyDescription.copyWith(fontSize: 20.0),
                            ),
                            textColor: AppColors.grey,
                            leading: Icon(
                              size: 30,
                              Icons.account_box_outlined,
                              color: AppColors.regularBlack.withOpacity(0.2),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              userEmail ?? '',
                              style: bodyDescription.copyWith(fontSize: 20.0),
                            ),
                            textColor: AppColors.grey,
                            leading: Icon(
                              size: 30,
                              Icons.email_outlined,
                              color: AppColors.regularBlack.withOpacity(0.2),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text('Data não disponível');
                    }
                  },
                ),
                const SizedBox(height: 35),
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
                    _uploadPhotoModal(context,
                        title: 'Deletar Conta',
                        rightButtonTitle: 'Deletar',
                        leftButtonTitle: 'Cancelar',
                        leftButtonAction: await FirebaseUtils.deleteUser());
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
                    _uploadPhotoModal(
                      context,
                      title: 'Sair',
                      rightButtonTitle: 'Sim',
                      leftButtonTitle: 'Não',
                      leftButtonAction: await FirebaseUtils.signOut(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _uploadPhotoModal(
    BuildContext context, {
    required String title,
    required String rightButtonTitle,
    required String leftButtonTitle,
    required leftButtonAction,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 230,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 16.0),
                child: Text(
                  title,
                  style: bodyDescription.copyWith(fontSize: 25),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GestureDetector(
                  onTap: () {
                    profileBloc.add(NewPhotoEvent());
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 130,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pink,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () async {
                            await leftButtonAction;
                            Navigator.of(context).pushNamed('/login_page');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              rightButtonTitle,
                              style: button.copyWith(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pink,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () async {
                            // await leftButtonAction;
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              leftButtonTitle,
                              style: button.copyWith(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getPhotoPah() {
    if (profileBloc.photoPath == '') {
      return 'assets/icons/photo_attach.svg';
    } else {
      return profileBloc.photoPath;
    }
  }
}
