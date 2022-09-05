import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_social_login/flutter_social_login_method_channel.dart';

void main() {
  MethodChannelFlutterSocialLogin platform = MethodChannelFlutterSocialLogin();
  const MethodChannel channel = MethodChannel('flutter_social_login');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
