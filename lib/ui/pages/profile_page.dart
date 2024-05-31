import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Import necessário para SchedulerBinding
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/firebase_utils.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/preferences.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/profile/profile_bloc.dart';
import 'package:safe_nails/ui/bloc/profile/profile_event.dart';
import 'package:safe_nails/ui/bloc/profile/profile_state.dart';
import 'package:safe_nails/ui/widgets/app_version.dart';
import 'package:safe_nails/ui/widgets/banner_ad.dart';
import 'package:safe_nails/ui/widgets/loading.dart';
import 'package:safe_nails/ui/widgets/toast_alert.dart';

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

  final String bannerId = Platform.isAndroid
      ? dotenv.env['ANDROID_BANNER_ID']!
      : dotenv.env['IOS_BANNER_ID']!;

  Future<Map<String, dynamic>> _getUserData() async {
    return await Preferences().getUserData();
  }

  @override
  void initState() {
    super.initState();
    sl<Analytics>().onScreenView(AnalyticsEventTags.profile_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocConsumer<ProfileBloc, ProfileState>(
                        bloc: profileBloc,
                        listener: (context, state) {
                          if (state is ProfilePermissionDeniedState) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                toastAlert(type: ToastType.error, messages: [
                                  "Você precisa permitir que o app acesse sua galeria de fotos nas suas configurações."
                                ]),
                              );
                            });
                          } else if (state is ProfileErrorState) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                toastAlert(
                                    type: ToastType.error,
                                    messages: [state.errorMessage]),
                              );
                            });
                          }
                        },
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
                                const SizedBox(height: 20),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      profileBloc.add(NewPhotoEvent());
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 180,
                                          width: 180.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.account_circle,
                                              color: AppColors.pink
                                                  .withOpacity(0.2),
                                              size: 120,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(200.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: AppColors.pink
                                                    .withOpacity(0.6),
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            );
                          }
                          if (state is ProfileLoadedState) {
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  profileBloc.add(NewPhotoEvent());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30.0),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200.0),
                                        child: Image.file(
                                          File(profileBloc.photoPath),
                                          height: 180.0,
                                          width: 180.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.camera_alt_rounded,
                                              color: AppColors.pink
                                                  .withOpacity(0.6),
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      FutureBuilder<Map<String, dynamic>>(
                        future: _getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final userData = snapshot.data!;
                            final userName = userData['name'];
                            final userEmail = userData['email'];
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    userName ?? '',
                                    style: bodyDescription.copyWith(
                                        fontSize: 15.0),
                                  ),
                                  textColor: AppColors.grey,
                                  leading: Icon(
                                    size: 25,
                                    Icons.account_box_outlined,
                                    color: AppColors.pink.withOpacity(0.6),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    userEmail ?? '',
                                    style: bodyDescription.copyWith(
                                        fontSize: 15.0),
                                  ),
                                  textColor: AppColors.grey,
                                  leading: Icon(
                                    size: 25,
                                    Icons.email_outlined,
                                    color: AppColors.pink.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text(
                              CommonStrings.loadingInfo,
                              style: bodyDescription.copyWith(fontSize: 14),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              CommonStrings.deleteAccount,
                              style: bodyDescription.copyWith(fontSize: 14),
                            ),
                            textColor: AppColors.grey,
                            trailing: Icon(
                              Icons.chevron_right,
                              color: AppColors.regularBlack.withOpacity(0.2),
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color:
                                      AppColors.regularGrey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onTap: () async {
                              _uploadPhotoModal(context,
                                  title: CommonStrings.deleteAccount,
                                  rightButtonTitle: CommonStrings.delete,
                                  leftButtonTitle: CommonStrings.back);
                            },
                          ),
                          SizedBox(height: 15),
                          ListTile(
                            title: Text(
                              CommonStrings.out,
                              style: bodyDescription.copyWith(fontSize: 14),
                            ),
                            textColor: AppColors.grey,
                            trailing: Icon(
                              Icons.chevron_right,
                              color: AppColors.regularGrey.withOpacity(0.2),
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color:
                                      AppColors.regularGrey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onTap: () async {
                              _uploadPhotoModal(
                                context,
                                title: CommonStrings.out,
                                rightButtonTitle: CommonStrings.yes,
                                leftButtonTitle: CommonStrings.not,
                              );
                            },
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: BannerAdmob(
                                idAdMob: bannerId,
                              ),
                            ),
                          ),
                          AppVersion(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _uploadPhotoModal(
    BuildContext context, {
    required String title,
    required String rightButtonTitle,
    required String leftButtonTitle,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 230,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: AppColors.background,
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
                            backgroundColor: AppColors.pink.withOpacity(0.8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () async {
                            var auth = await getButtonAction(title);

                            if (auth == CommonStrings.success) {
                              Navigator.of(context).pushNamed('/welcome_page');
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
                            backgroundColor: AppColors.pink.withOpacity(0.8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () async {
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

  getButtonAction(String title) async {
    if (title == CommonStrings.out) {
      return await FirebaseUtils.signOut();
    } else {
      return await FirebaseUtils.deleteUser();
      //TODO ADD DELETE_USER DATA.
    }
  }
}
