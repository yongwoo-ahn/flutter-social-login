import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../auth_constant.dart';
import '../auth_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({required this.email, Key? key}) : super(key: key);

  final String email;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  TextEditingController? textController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool passwordAllCheck = false;
  bool passwordHiddenCheck = true; //비밀번호 보기

  Color loginButtonFillColor = const Color(0xFF303030); //로그인 버튼 색깔
  Color loginButtonFontColor = const Color(0xFF575757); //로그인 버튼 글자색

  Color checkPasswordEnglishColor = const Color(0xFF6c6c6c); //비번 영어조건 체크 색
  Color checkPasswordNumberColor = const Color(0xFF6c6c6c); //비번 숫자조건 체크 색
  Color checkPasswordLengthColor = const Color(0xFF6c6c6c); //비번 길이조건 체크 색

  String passwordHiddenImage = 'assets/images/icon_eye.png'; //비밀번호 보기 이미지
  String passwordHiddenText = '보기'; //비밀번호 보기 텍스트

  String checkPasswordEnglishImage =
      'assets/images/status_check_gr.png'; //비번 영어조건 체크 이미지
  String checkPasswordNumberImage =
      'assets/images/status_check_gr.png'; //비번 숫자조건 체크 이미지
  String checkPasswordLengthImage =
      'assets/images/status_check_gr.png'; //비번 길이조건 체크 이미지

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: appBar(),
      ),
      backgroundColor: const Color(0xFF1F1F1F),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  emailIdTitle(), //이메일 아이디 title
                  userEmailId(), //사용자 이메일 아이디
                  passwordTitle(), //비밀번호 title
                  inputPassword(), //비밀번호 입력
                  checkPasswordCondition(), //비밀번호 조건체크
                  loginButton(), //로그인 버튼
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color(0x004B39EF),
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () async {
          Navigator.pop(context);
        },
        child: Image.asset(
          'assets/images/icon_back_wh.png',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        '회원가입',
        style: FlutterFlowTheme.of(context).title2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 14,
            ),
      ),
      actions: const [],
      centerTitle: false,
      elevation: 0,
    );
  }

  Widget emailIdTitle() {
    //이메일 아이디
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 38, 0, 0),
      child: Text(
        '이메일 아이디',
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              color: const Color(0xFFE8E8E8),
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }

  Widget userEmailId() {
    return Padding(
      //입력받은 이메일
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Container(
        height: 18,
        decoration: const BoxDecoration(
          color: Color(0x00FFFFFF),
        ),
        child: Text(
          widget.email,
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }

  Widget passwordTitle() {
    return Padding(
      //비밀번호
      padding: const EdgeInsetsDirectional.fromSTEB(0, 41, 0, 0),
      child: Container(
        width: 320,
        height: 16,
        decoration: const BoxDecoration(
          color: Color(0x00FFFFFF),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '비밀번호',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: const Color(0xFFE8E8E8),
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Text(
              '(1회만 입력)',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: const Color(0xFFE8E8E8),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                debugPrint('click eye');
                setState(() {
                  if (passwordHiddenCheck == true) {
                    passwordHiddenCheck = false;
                    passwordHiddenImage = 'assets/images/icon_eye_off.png';
                    passwordHiddenText = '숨기기';
                  } else {
                    passwordHiddenCheck = true;
                    passwordHiddenImage = 'assets/images/icon_eye.png';
                    passwordHiddenText = '보기';
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Image.asset(
                  passwordHiddenImage,
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              child: Text(
                passwordHiddenText,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: const Color(0xFFA5A5A5),
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputPassword() {
    return Padding(
      //비밀번호 입력
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
      child: Container(
        width: 320,
        height: 44,
        decoration: const BoxDecoration(
          color: Color(0x00303030),
        ),
        child: TextFormField(
          controller: textController,
          autofocus: true,
          obscureText: passwordHiddenCheck,
          decoration: InputDecoration(
            hintText: '로그인에 사용할 비밀번호를 입력해주세요.',
            hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'Poppins',
                  color: const Color(0xFF6C6C6C),
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
            suffixIcon: textController!.text.isEmpty
                ? null
                : IconButton(
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/images/icon_erase.png'),
                    onPressed: () {
                      setState(() {
                        textController!.clear();

                        checkPasswordEnglishColor = const Color(0xFF6c6c6c);
                        checkPasswordEnglishImage =
                            'assets/images/status_check_gr.png';

                        checkPasswordNumberColor = const Color(0xFF6c6c6c);
                        checkPasswordNumberImage =
                            'assets/images/status_check_gr.png';

                        checkPasswordLengthColor = const Color(0xFF6c6c6c);
                        checkPasswordLengthImage =
                            'assets/images/status_check_gr.png';

                        loginButtonFillColor = const Color(0xFF303030);
                        loginButtonFontColor = const Color(0xFF575757);
                      });
                    },
                  ),
          ),
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
          onChanged: (text) {
            var check = checkPasswordConditions(text);

            setState(() {
              if (check.checkEnglish == true) {
                checkPasswordEnglishColor = const Color(0xFF14B9CB);
                checkPasswordEnglishImage =
                    'assets/images/status_check_mint.png';
              } else {
                checkPasswordEnglishColor = const Color(0xFF6c6c6c);
                checkPasswordEnglishImage = 'assets/images/status_check_gr.png';
              }

              if (check.checkNumber == true) {
                checkPasswordNumberColor = const Color(0xFF14B9CB);
                checkPasswordNumberImage =
                    'assets/images/status_check_mint.png';
              } else {
                checkPasswordNumberColor = const Color(0xFF6c6c6c);
                checkPasswordNumberImage = 'assets/images/status_check_gr.png';
              }

              if (check.checkLength == true) {
                checkPasswordLengthColor = const Color(0xFF14B9CB);
                checkPasswordLengthImage =
                    'assets/images/status_check_mint.png';
              } else {
                checkPasswordLengthColor = const Color(0xFF6c6c6c);
                checkPasswordLengthImage = 'assets/images/status_check_gr.png';
              }

              if (check.allCheck == true) {
                passwordAllCheck = true;
                loginButtonFillColor = const Color(0xFFFF0099);
                loginButtonFontColor = const Color(0xFFFFFFFF);
              } else {
                passwordAllCheck = false;
                loginButtonFillColor = const Color(0xFF303030);
                loginButtonFontColor = const Color(0xFF575757);
              }
            });
          },
        ),
      ),
    );
  }

  Widget checkPasswordConditionItem(
      String conditionText, String img, Color color) {
    return Row(
      children: [
        Image.asset(
          img,
          width: 12,
          height: 8,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
          child: Text(
            conditionText,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        const SizedBox(width: 16)
      ],
    );
  }

  Widget checkPasswordCondition() {
    return Padding(
      //비밀번호 조건 체크
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: Container(
        width: 320,
        height: 16,
        decoration: const BoxDecoration(
          color: Color(0x00FFFFFF),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            checkPasswordConditionItem(
                '영문포함', checkPasswordEnglishImage, checkPasswordEnglishColor),
            checkPasswordConditionItem(
                '숫자포함', checkPasswordNumberImage, checkPasswordNumberColor),
            checkPasswordConditionItem(
                '8자이상', checkPasswordLengthImage, checkPasswordLengthColor),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      //이메일 인증 버튼
      padding: const EdgeInsetsDirectional.fromSTEB(0, 113, 0, 0),
      child: FFButtonWidget(
        onPressed: () {
          if (passwordAllCheck == true) {
            //getAccountSignInWithEmail(widget.email, textController!.text);
            getToken(widget.email, textController!.text);
          }
        },
        text: '이메일 인증',
        options: FFButtonOptions(
          width: 320,
          height: 44,
          color: loginButtonFillColor,
          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: 'Poppins',
                color: loginButtonFontColor,
                fontSize: 14,
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
}

//비밀번호 조건 체크
class CheckPassword {
  bool checkEnglish;
  bool checkNumber;
  bool checkLength;

  CheckPassword({
    this.checkEnglish = false,
    this.checkNumber = false,
    this.checkLength = false,
  });

  bool get allCheck => (checkEnglish && checkNumber && checkLength);
}

CheckPassword checkPasswordConditions(String password) {
  var checkPassword = CheckPassword();

  final checkPasswordEnglish = RegExp(r"[a-zA-Z]");
  final checkPasswordNumber = RegExp(r"(\d+)");

  //비밀번호를 입력하지 않은 경우
  if (password.isEmpty) {
    return CheckPassword();
  }

  //영문포함
  if (checkPasswordEnglish.hasMatch(password)) {
    checkPassword.checkEnglish = true;
  } else {
    checkPassword.checkEnglish = false;
  }

  //숫자포함
  if (checkPasswordNumber.hasMatch(password)) {
    checkPassword.checkNumber = true;
  } else {
    checkPassword.checkNumber = false;
  }

  //글자수
  if (password.length >= 8) {
    checkPassword.checkLength = true;
  } else {
    checkPassword.checkLength = false;
  }

  return checkPassword;
}

//로그인
class AccountSignInWithEmail {
  final bool result;
  final String message;
  final String code;
  final Object? externalData;
  final Object user;
  final String refreshToken;
  final String accessToken;

  AccountSignInWithEmail({
    required this.result,
    required this.message,
    required this.code,
    required this.externalData,
    required this.user,
    required this.refreshToken,
    required this.accessToken,
  });

  factory AccountSignInWithEmail.fromJson(Map<String, dynamic> json) {
    return AccountSignInWithEmail(
      result: json['result'],
      message: json['message'],
      code: json['code'],
      externalData: json['externalData'],
      user: json['user'],
      refreshToken: json['refresh_token'],
      accessToken: json['access_token'],
    );
  }
}

Future<AccountSignInWithEmail> getAccountSignInWithEmail(
    String email, String password) async {
  const storage = FlutterSecureStorage();

  Map data = {
    'email': email,
    'password': password,
  };

  final response = await http.post(
    Uri.parse(
        'https://auth-dev.makestar.com/apis/v1/user/account/signin_with_email/'),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode(data),
  );

  final responseUTF8 = utf8.decode(response.bodyBytes);
  final responseJson = jsonDecode(responseUTF8);

  if (response.statusCode == 200) {
    debugPrint(
        'login message: ${AccountSignInWithEmail.fromJson(responseJson).message}');
    debugPrint(
        'accessToken: ${AccountSignInWithEmail.fromJson(responseJson).accessToken}');
    debugPrint(
        'refreshToken: ${AccountSignInWithEmail.fromJson(responseJson).refreshToken}');

    await storage.write(
        key: 'AcessToken',
        value: AccountSignInWithEmail.fromJson(responseJson).accessToken);
    await storage.write(
        key: 'RefreshToken',
        value: AccountSignInWithEmail.fromJson(responseJson).refreshToken);

    var allToken = await storage.readAll();
    debugPrint('allToken: $allToken');
  } else {
    debugPrint('login fail${response.statusCode}');
  }

  return AccountSignInWithEmail.fromJson(responseJson);
}

//dio
Future<bool> getToken(String email, String password) async {
  const storage = FlutterSecureStorage();

  AuthAPIRequest apiRequest =
      await (AuthAPIRequestBuilder(AuthConstant.apiLoginURL, 'POST')
            ..withBodyData({
              AuthConstant.paramEmail: email,
              AuthConstant.paramPassword: password,
            }))
          .build();
  try {
    dio.Response response = await apiRequest.send();
    final jsonData = response.data;

    await storage.write(
        key: 'AcessToken', value: jsonData[AuthConstant.paramAccessToken]);
    await storage.write(
        key: 'RefreshToken', value: jsonData[AuthConstant.paramAccessToken]);

    return jsonData[AuthConstant.paramResult];
  } on Exception {
    return false;
  }
}
