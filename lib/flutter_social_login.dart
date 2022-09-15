// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart'
    as kakao_login;
import 'package:twitter_login/twitter_login.dart';
import 'flutter_social_login_platform_interface.dart';

import 'package:flutter_social_login/constant.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

class FlutterSocialLogin {
  Future<String?> getPlatformVersion() {
    return FlutterSocialLoginPlatform.instance.getPlatformVersion();
  }

  Future<UserCredential?> signInWithTwitter(
      String apiKey, String apiSecretKey, String redirectUri) async {
    final twitterLogin = TwitterLogin(
        apiKey: apiKey, apiSecretKey: apiSecretKey, redirectURI: redirectUri);

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();
    if (authResult.authToken == null || authResult.authTokenSecret == null) {
      return null;
    }
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  Future<String?> signInWithKakao() async {
    await kakao_login.UserApi.instance.loginWithKakaoAccount();
    kakao_login.User user = await kakao_login.UserApi.instance.me();
    String id = "KAKAO_${user.id}";
    Map<String, dynamic> profile = user.toJson();
    profile["id"] = user.id.toString();
    profile["email"] = user.kakaoAccount?.email;
    String? token = getFirebaseAuthToken(id, profile);
    return token;
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    FacebookAuth.instance.logOut();
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.accessToken == null) {
      return null;
    }

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      return null;
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String?> signInWithNaver() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    String id = "NAVER_${res.account.id}";
    final Map<String, dynamic> profile = {};
    profile["nickname"] = res.account.nickname;
    profile["id"] = res.account.id;
    profile["name"] = res.account.name;
    profile["email"] = res.account.email;
    profile["gender"] = res.account.gender;
    profile["age"] = res.account.age;
    profile["birthday"] = res.account.birthday;
    profile["birthyear"] = res.account.birthyear;
    profile["profileImage"] = res.account.profileImage;
    profile["mobile"] = res.account.mobile;
    profile["mobileE164"] = res.account.mobileE164;
    String? token = getFirebaseAuthToken(id, profile);
    return token;
  }

  Future<LinkedHashMap<String, String?>> signInWithAppleForAndroid() async {
    return FlutterSocialLoginPlatform.instance.signInWithAppleForAndroid();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  String? getFirebaseAuthToken(String id, Map<String, dynamic> profile) {
    return "";
  }

  String generateNonce([int length = 32]) {
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
