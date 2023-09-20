import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/remote_config_service.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/profile/profile_bloc.dart';
import 'package:safe_nails/ui/bloc/tips/tips_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => TextStyles());
  sl.registerLazySingleton<AnalysisBloc>(() => AnalysisBloc());
  sl.registerLazySingleton<TipsBloc>(() => TipsBloc());
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  sl.registerLazySingleton(() => FirebaseRemoteConfig.instance);
  sl.registerLazySingleton(() => RemoteConfig(sl()));
  sl.registerLazySingleton(() => Analytics());
}
