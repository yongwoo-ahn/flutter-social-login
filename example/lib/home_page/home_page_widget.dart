import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../password/password_widget.dart';
import '../auth_constant.dart';
import '../auth_api.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController? textController;

  late bool accountInfoBoxVisible = false; //계정 도움말 박스 표시 여부
  late bool checkEmailFormat = false; //이메일 조건 체크
  late Color loginButtonFillColor = const Color(0xFF303030); //로그인 버튼 색깔
  late Color loginButtonFontColor = const Color(0xFF575757); //로그인 버튼 글자색

  final emailFormat = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+"); //이메일 조건
  final scaffoldKey = GlobalKey<ScaffoldState>();

  checkEmailCallback(bool checkInputEmail) {
    setState(() {
      if (checkInputEmail == true) {
        debugPrint('Email correct...');
        if (!mounted) {
          //buildContext 할당하지 않으면
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PasswordWidget(
                      email: textController!.text,
                    )));
      } else {
        debugPrint('Email incorrect...');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF1F1F1F),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                titleLogo(), //로고
                accountInformation(), //계정 안내
                inputEmail(), //이메일 입력란
                loginButton(), //이메일 로그인 버튼
                orContinueWithSocialAccount(),
                socialLoginButtons(), //소셜 로그인 버튼
                agreeTerms(), //약관동의
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleLogo() {
    //로고
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
      child: Container(
        width: 320,
        height: 110,
        decoration: const BoxDecoration(
          color: Color(0x00FFFFFF),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: SvgPicture.asset(
                  'assets/images/img_loginlogo.svg',
                  width: 148,
                  height: 16,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Visibility(
                  visible: accountInfoBoxVisible,
                  child: Container(
                    width: 227,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161616),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                      child: Text(
                        '메이크스타 계정 하나로 포카앨범, 메이크스타, 와츠비 서비스를 모두 이용할 수 있어요.',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: const Color(0xFFA5A5A5),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountInformation() {
    //도움말
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(67, 0, 55, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 13, 0, 12),
            child: Text(
              '포카앨범은 메이크스타 계정을 사용해요!',
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: const Color(0xFFA5A5A5),
                    fontSize: 13,
                    fontWeight: FontWeight.w100,
                  ),
            ),
          ),
          InkWell(
            onTap: () async {
              setState(() {
                if (accountInfoBoxVisible == true) {
                  accountInfoBoxVisible = false;
                } else {
                  accountInfoBoxVisible = true;
                }
              });
            },
            child: SvgPicture.asset(
              'assets/images/icon_tooltip.svg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget inputEmail() {
    //이메일 입력란
    return Container(
      width: 320,
      height: 44,
      decoration: const BoxDecoration(
        color: Color(0x00FFFFFF),
      ),
      child: TextFormField(
        controller: textController,
        autofocus: true,
        obscureText: false,
        decoration: InputDecoration(
          hintText: '메이크스타 이메일 아이디\n',
          hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
                fontFamily: 'Poppins',
                color: const Color(0xFF575757),
                fontWeight: FontWeight.normal,
              ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          filled: true,
          fillColor: const Color(0xFF303030),
        ),
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
        textAlign: TextAlign.start,
        onChanged: (text) {
          if (emailFormat.hasMatch(text)) {
            setState(() {
              loginButtonFillColor = const Color(0XFFFF0099);
              loginButtonFontColor = const Color(0xFFFFFFFF);
              checkEmailFormat = true;
            });
          } else {
            setState(() {
              loginButtonFillColor = const Color(0xFF303030);
              loginButtonFontColor = const Color(0xFF575757);
              checkEmailFormat = false;
            });
          }
        },
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: FFButtonWidget(
        onPressed: () {
          if (checkEmailFormat == true) {
            //getAccountIsRegisteredEmail(textController!.text);

            checkUsingEmail(textController!.text).then((value) => {
                  if (value == true)
                    {checkEmailCallback(true)}
                  else
                    {checkEmailCallback(false)}
                });
          } else {
            return;
          }
        },
        text: '이메일로 계속하기',
        options: FFButtonOptions(
          width: 320,
          height: 44,
          //color: const Color(0xFF303030),
          color: loginButtonFillColor,
          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: 'Poppins',
                color: loginButtonFontColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget orContinueWithSocialAccount() {
    //or continue with social account
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 0.1,
            decoration: const BoxDecoration(
              color: Color(0xFFA5A5A5),
            ),
          ),
          Text(
            ' or continue with social account ',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'Poppins',
                  color: const Color(0xFFA5A5A5),
                  fontWeight: FontWeight.normal,
                ),
          ),
          Container(
            width: 50,
            height: 0.1,
            decoration: const BoxDecoration(
              color: Color(0xFFA5A5A5),
            ),
          ),
        ],
      ),
    );
  }

  Widget socialLoginButtons() {
    String twitterLogo = 'assets/images/login_logo_twitter.png';
    String facebookLogo = 'assets/images/login_logo_facebook.png';
    String naverLogo = 'assets/images/naver.png';
    String kakaoLogo = 'assets/images/login_logo_kakao.png';
    String googleLogo = 'assets/images/login_logo_google.png';
    String appleLogo = 'assets/images/login_logo_apple_black.png';

    return Padding(
      //소셜 로그인 버튼
      padding: const EdgeInsetsDirectional.fromSTEB(94, 40, 94, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                socialLoginButton(twitterLogo, sampleOnClick),
                socialLoginButton(facebookLogo, sampleOnClick),
                socialLoginButton(naverLogo, sampleOnClick),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                socialLoginButton(kakaoLogo, sampleOnClick),
                socialLoginButton(googleLogo, sampleOnClick),
                socialLoginButton(appleLogo, sampleOnClick),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialLoginButton(String img, Function? onClick) {
    return InkWell(
      onTap: () async {
        onClick!();
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0x30A5A5A5),
            width: 1,
          ),
        ),
        child: Image.asset(
          img,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  TextSpan agreeTermsTextSpan(String text) {
    return TextSpan(
      text: text,
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            color: const Color(0xFFA5A5A5),
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
    );
  }

  Widget agreeTerms() {
    //약관동의
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 102, 0, 0),
      child: RichText(
        text: TextSpan(
          children: [
            agreeTermsTextSpan('회원가입/로그인하여 '),
            TextSpan(
              text: '이용약관',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  color: const Color(0xFFFFFFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('이용약관 클릭');
                  // var usingEmail = checkUsingEmail(textController!.text);
                },
            ),
            agreeTermsTextSpan('과 '),
            TextSpan(
              text: '개인정보취급방침',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  color: const Color(0xFFFFFFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('개인정보취급방침  클릭');
                },
            ),
            agreeTermsTextSpan('에 동의합니다.'),
          ],
        ),
      ),
    );
  }

  sampleOnClick() {
    debugPrint('Click');
  }

  Future<AccountIsRegisteredEmail> getAccountIsRegisteredEmail(
      String email) async {
    Map data = {'email': email};

    const String registeredEmailUrl =
        'https://auth-dev.makestar.com/apis/v1/user/account/is_registered_email/';

    final response = await http.post(
      Uri.parse(registeredEmailUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(data),
    );
    //final responseJson = jsonDecode(response.body);

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final responseJson = jsonDecode(responseUTF8);

    if (response.statusCode == 200) {
      debugPrint(
          'normal login result: ${AccountIsRegisteredEmail.fromJson(responseJson).result}');

      setState(() {
        if (AccountIsRegisteredEmail.fromJson(responseJson).result == true) {
          checkEmailCallback(true);
        } else {
          checkEmailCallback(false);
        }
      });
    } else {
      debugPrint('normal login fail: ${response.statusCode}');
    }

    return AccountIsRegisteredEmail.fromJson(responseJson);
  }

  //dio
  Future<bool> checkUsingEmail(String email) async {
    AuthAPIRequest apiRequest = await (AuthAPIRequestBuilder(
            AuthConstant.apiIsRegisteredEmailURL, 'POST')
          ..withBodyData({
            AuthConstant.paramEmail: email,
          }))
        .build();
    try {
      dio.Response response = await apiRequest.send();
      final jsonData = response.data;
      return jsonData[AuthConstant.paramResult];
    } on Exception {
      return false;
    }
  }
}

//일반 로그인 이메일 회원가입 여부 확인
class AccountIsRegisteredEmail {
  final bool result;
  final String message;
  final String code;
  final Object? externalData;

  AccountIsRegisteredEmail({
    required this.result,
    required this.message,
    required this.code,
    required this.externalData,
  });

  factory AccountIsRegisteredEmail.fromJson(Map<String, dynamic> json) {
    return AccountIsRegisteredEmail(
      result: json['result'],
      message: json['message'],
      code: json['code'],
      externalData: json['external_data'],
    );
  }
}

//소셜 로그인 회원가입여부 확인
class AccountIsRegisteredSocialAccount {
  final bool result;
  final String message;
  final String code;
  final Object? externalData;

  AccountIsRegisteredSocialAccount({
    required this.result,
    required this.message,
    required this.code,
    required this.externalData,
  });

  factory AccountIsRegisteredSocialAccount.fromJson(Map<String, dynamic> json) {
    return AccountIsRegisteredSocialAccount(
        result: json['result'],
        message: json['message'],
        code: json['code'],
        externalData: json['external_data']);
  }
}

Future<AccountIsRegisteredSocialAccount> getAccountIsRegisteredSocialAccount(
    String social, String socialID) async {
  String? socialSite;

  switch (social) {
    case 'MAKESTAR':
      socialSite = 'Makestar';
      break;
    case 'GOOGLE':
      socialSite = 'Google';
      break;
    case 'TWITTER':
      socialSite = 'Twitter';
      break;
    case 'FACEBOOK':
      socialSite = 'Twitter';
      break;
    case 'APPLE':
      socialSite = 'Apple';
      break;
    case 'KAKAO':
      socialSite = 'Kakao';
      break;
    case 'NAVER':
      socialSite = 'Naver';
      break;
  }

  Map data = {
    'social_provider': [social, socialSite!],
    'social_id': socialID,
  };

  final response = await http.post(
    Uri.parse(
        'https://auth-dev.makestar.com/apis/v1/user/account/is_registered_email/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );
  final responseJson = jsonDecode(response.body);

  if (response.statusCode == 200) {
    debugPrint(
        'social login result: ${AccountIsRegisteredSocialAccount.fromJson(responseJson).result}');
  } else {
    debugPrint('social login fail${response.statusCode}');
  }

  return AccountIsRegisteredSocialAccount.fromJson(responseJson);
}
