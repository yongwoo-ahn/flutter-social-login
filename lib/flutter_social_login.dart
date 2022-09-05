// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';

import 'flutter_social_login_platform_interface.dart';

class FlutterSocialLogin {
  Future<String?> getPlatformVersion() {
    return FlutterSocialLoginPlatform.instance.getPlatformVersion();
  }

  Future<UserCredential?> signInWithTwitter() async {
    return FlutterSocialLoginPlatform.instance.signInWithTwitter();
  }

  static Future<Map<String, dynamic>> signInWithKakao() async {
    return FlutterSocialLoginPlatform.instance.signInWithKakao();
  }

  Future<UserCredential?> signInWithFacebook() async {
    return FlutterSocialLoginPlatform.instance.signInWithFacebook();
  }

  Future<UserCredential?> signInWithGoogle() async {
    return FlutterSocialLoginPlatform.instance.signInWithGoogle();
  }

  Future<LinkedHashMap<String, dynamic>> signInWithNaver() async {
    return FlutterSocialLoginPlatform.instance.signInWithNaver();
  }

  Future<UserCredential?> signInWithAppleForAndroid() async {
    return FlutterSocialLoginPlatform.instance.signInWithAppleForAndroid();
  }

  Future<UserCredential?> signInWithApple() async {
    return FlutterSocialLoginPlatform.instance.signInWithApple();
  }
}
