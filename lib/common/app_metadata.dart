import 'package:package_info_plus/package_info_plus.dart';

class AppMetadata {
  Future<String> versionNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<int> buildNumber() async {
    return int.parse((await PackageInfo.fromPlatform()).buildNumber);
  }
}
