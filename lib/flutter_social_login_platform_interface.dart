import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_social_login_method_channel.dart';

abstract class FlutterSocialLoginPlatform extends PlatformInterface {
  /// Constructs a FlutterSocialLoginPlatform.
  FlutterSocialLoginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSocialLoginPlatform _instance =
      MethodChannelFlutterSocialLogin();

  /// The default instance of [FlutterSocialLoginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSocialLogin].
  static FlutterSocialLoginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSocialLoginPlatform] when
  /// they register themselves.
  static set instance(FlutterSocialLoginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<UserCredential?> signInWithTwitter(
      String apiKey,String apiSecretKey,String redirectUri) async {
    throw UnimplementedError('signInWithGoogle() has not been implemented.');
  }

  Future<Map<String, dynamic>> signInWithKakao() async {
    throw UnimplementedError('signInWithKakao() has not been implemented.');
  }

  Future<UserCredential?> signInWithFacebook() async {
    throw UnimplementedError('signInWithFacebook() has not been implemented.');
  }

  Future<UserCredential?> signInWithGoogle() async {
    throw UnimplementedError('signInWithGoogle() has not been implemented.');
  }

  Future<LinkedHashMap<String, dynamic>> signInWithNaver() async {
    throw UnimplementedError('signInWithNaver() has not been implemented.');
  }

  Future<LinkedHashMap<String, String?>> signInWithAppleForAndroid() async {
    throw UnimplementedError(
        'signInWithAppleForAndroid() has not been implemented.');
  }

  Future<UserCredential> signInWithApple() async {
    throw UnimplementedError('signInWithApple() has not been implemented.');
  }
}
