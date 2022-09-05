import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_social_login/flutter_social_login.dart';
import 'package:flutter_social_login/flutter_social_login_platform_interface.dart';
import 'package:flutter_social_login/flutter_social_login_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSocialLoginPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterSocialLoginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<UserCredential?> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithAppleForAndroid() {
    // TODO: implement signInWithAppleForAndroid
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> signInWithKakao() {
    // TODO: implement signInWithKakao
    throw UnimplementedError();
  }

  @override
  Future<LinkedHashMap<String, dynamic>> signInWithNaver() {
    // TODO: implement signInWithNaver
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithTwitter() {
    // TODO: implement signInWithTwitter
    throw UnimplementedError();
  }
}

void main() {
  final FlutterSocialLoginPlatform initialPlatform = FlutterSocialLoginPlatform.instance;

  test('$MethodChannelFlutterSocialLogin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSocialLogin>());
  });

  test('getPlatformVersion', () async {
    FlutterSocialLogin flutterSocialLoginPlugin = FlutterSocialLogin();
    MockFlutterSocialLoginPlatform fakePlatform = MockFlutterSocialLoginPlatform();
    FlutterSocialLoginPlatform.instance = fakePlatform;
  
    expect(await flutterSocialLoginPlugin.getPlatformVersion(), '42');
  });
}
