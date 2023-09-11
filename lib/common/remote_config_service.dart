import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:safe_nails/common/injection_container.dart';

class RemoteConfig {
  final FirebaseRemoteConfig remoteConfig;

  RemoteConfig(this.remoteConfig);

  Future<void> init() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(minutes: 10),
      ),
    );

    await remoteConfig.setDefaults(<String, dynamic>{
      'allowedUsers': '''{'allowed_users': [a@email.com]}''',
    });

    await updateValues();
  }

  Future<void> updateValues() async {
    try {
      await sl<RemoteConfig>().updateValues();
    } catch (e) {
      print('Error fetching Remote Config values: $e');
    }
    ;
  }

  String getValue(String key) {
    return remoteConfig.getValue(key).asString();
  }
}
