import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/constant/pacaalbum_constant.dart';
import '/controller/auth_api.dart';

class PocaalbumAPIRequset {
  final Dio dio = Dio();
  final String baseUrl;
  final String relativeUrl;
  final String method;
  Map<String, dynamic>? data;
  Map<String, dynamic> headers;
  Map<String, dynamic>? queryParameters;

  PocaalbumAPIRequset._builder(Builder builder)
      : relativeUrl = builder.relativeUrl,
        baseUrl = builder.getBaseUrl(),
        method = builder.httpRequestMethod,
        data = builder.data,
        headers = builder.headers,
        queryParameters = builder.queryParameters;

  Future<Response> send() {
    dio.options.connectTimeout = PocaAlbumConstant.serviceBaseTimeout;
    dio.options.receiveTimeout = PocaAlbumConstant.serviceBaseTimeout;
    dio.options.sendTimeout = PocaAlbumConstant.serviceBaseTimeout;

    dio.options.baseUrl = baseUrl;
    dio.options.method = method;
    dio.options.headers = headers;

    return dio.request(relativeUrl,
        data: data, queryParameters: queryParameters);
  }
}

class PocaalbumAPIRequsetBuilder implements Builder {
  @override
  final String relativeUrl;
  @override
  final String httpRequestMethod;

  PocaalbumAPIRequsetBuilder(this.relativeUrl, this.httpRequestMethod);

  @override
  Map<String, dynamic> headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.value,
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
    buffer.write(PocaAlbumConstant.pocaalbumURL);
    buffer.write(PocaAlbumConstant.apiBaseURL);
    return buffer.toString();
  }

  Future<PocaalbumAPIRequset> build() async {
    const storage = FlutterSecureStorage();

    if (withId) {
      String? token = await storage.read(key: 'AcessToken');
      headers[HttpHeaders.authorizationHeader] =
          "${PocaAlbumConstant.apiAuthPrefix} ${token!}";
    }
    return PocaalbumAPIRequset._builder(this);
  }
}
