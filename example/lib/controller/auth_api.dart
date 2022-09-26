import 'dart:io';

import 'package:dio/dio.dart';
//import 'package:pocaalbum/controller/user/user_controller.dart';
//import 'package:pocaalbum/utils/common/exception.dart';
//import 'package:pocaalbum/utils/constant/auth_constant.dart';
import '/constant/auth_constant.dart';

class Builder {
  final String relativeUrl;
  final String httpRequestMethod;

  Builder(this.relativeUrl, this.httpRequestMethod);

  Map<String, dynamic>? data;
  Map<String, dynamic> headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.value
  };
  Map<String, dynamic>? queryParameters;

  getBaseUrl() {}
}

class AuthAPIRequest {
  final Dio dio = Dio();
  final String baseUrl;
  final String relativeUrl;
  final String method;
  Map<String, dynamic>? data;
  Map<String, dynamic> headers;
  Map<String, dynamic>? queryParameters;

  AuthAPIRequest._builder(Builder builder)
      : relativeUrl = builder.relativeUrl,
        baseUrl = builder.getBaseUrl(),
        method = builder.httpRequestMethod,
        data = builder.data,
        headers = builder.headers,
        queryParameters = builder.queryParameters;

  Future<Response> send() {
    dio.options.connectTimeout = AuthConstant.serviceBaseTimeout;
    dio.options.receiveTimeout = AuthConstant.serviceBaseTimeout;
    dio.options.sendTimeout = AuthConstant.serviceBaseTimeout;

    dio.options.baseUrl = baseUrl;
    dio.options.method = method;
    dio.options.headers = headers;

    return dio.request(relativeUrl,
        data: data, queryParameters: queryParameters);
  }
}

class AuthAPIRequestBuilder implements Builder {
  @override
  final String relativeUrl;
  @override
  final String httpRequestMethod;

  AuthAPIRequestBuilder(this.relativeUrl, this.httpRequestMethod);

  @override
  Map<String, dynamic> headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.value
  };
  @override
  Map<String, dynamic>? data;
  @override
  Map<String, dynamic>? queryParameters;
  bool withId = false;

  void withIdentification() {
    withId = true;
  }

  void withBodyData(Map<String, dynamic> data) {
    this.data = data;
  }

  void withQueryParams(Map<String, dynamic> queryParameters) {
    this.queryParameters = queryParameters;
  }

  @override
  String getBaseUrl() {
    StringBuffer buffer = StringBuffer();
    buffer.write(AuthConstant.accountURL);
    buffer.write(AuthConstant.apiBaseURL);
    return buffer.toString();
  }

  Future<AuthAPIRequest> build() async {
    /*if (withId) {
      String? token = await UserController.action.getAccessToken();
      headers[HttpHeaders.authorizationHeader] =
          "${AuthConstant.apiAuthPrefix} ${token!}";
    }*/
    return AuthAPIRequest._builder(this);
  }
}

abstract class LoginExceptionHandler {
  static LoginResult handleException(Exception exception) {
    if (exception is DioError) {
      /*MakestarException makestarException = MakestarException(exception);
      // AlertUtils.showErrorToast(makestarException.message);
      if (makestarException.isCustom) {
        if (makestarException.code == AuthConstant.responseCodeNotCertified) {
          return LoginResult.notCertified;
        } else {
          return LoginResult.failure;
        }
      } else {
        return LoginResult.failure;
      }*/
      return LoginResult.notCertified;
    } else {
      // AlertUtils.showErrorToast(exception.toString());
      return LoginResult.failure;
    }
  }
}
