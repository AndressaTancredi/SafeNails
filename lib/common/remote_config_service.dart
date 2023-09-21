import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    await remoteConfig.setDefaults(const {
      'allowedUsers': '''{'allowed-users': [a@email.com]}''',
    });

    await remoteConfig.fetchAndActivate();
  }

  String getValue(String key) {
    return remoteConfig.getValue(key).asString();
  }
}
