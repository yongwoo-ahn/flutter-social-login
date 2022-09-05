import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_social_login_platform_interface.dart';

/// An implementation of [FlutterSocialLoginPlatform] that uses method channels.
class MethodChannelFlutterSocialLogin extends FlutterSocialLoginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_social_login');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
