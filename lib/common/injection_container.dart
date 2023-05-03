import 'package:get_it/get_it.dart';
import 'package:safe_nails/common/text_styles.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => TextStyles());
}
