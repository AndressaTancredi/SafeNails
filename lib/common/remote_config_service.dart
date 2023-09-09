import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  final FirebaseRemoteConfig remoteConfig;

  RemoteConfig(this.remoteConfig);

  Future<void> init() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: const Duration(minutes: 10),
      ),
    );

    await remoteConfig.setDefaults(<String, dynamic>{
      'allowed_users': '''{'allowed_users': []}''',
    });
  }

  String getValue(String key) {
    return remoteConfig.getValue(key).asString();
  }
}
