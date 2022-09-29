import 'package:dio/dio.dart' as dio;
import 'package:flutter_social_login_example/constant/pacaalbum_constant.dart';

import '../constant/auth_constant.dart';
import '../controller/auth_api.dart';
import '../controller/pocaalbum_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> checkUsingEmail(String email) async {
  AuthAPIRequest apiRequest =
      await (AuthAPIRequestBuilder(AuthConstant.apiIsRegisteredEmailURL, 'POST')
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

Future<bool> saveToken(String email, String password) async {
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

Future<String> getOwnNfcAlbumList() async {
  PocaalbumAPIRequset pocaApiRequest = await (PocaalbumAPIRequsetBuilder(
          PocaAlbumConstant.apiGetOwnNfcAlbumListURL, 'POST')
        ..withIdentification())
      .build();
  try {
    dio.Response response = await pocaApiRequest.send();
    final jsonData = response.data;
    //debugPrint(jsonData[PocaAlbumConstant.paramExeternalData][PocaAlbumConstant.paramAlbumList].toString());

    return jsonData[PocaAlbumConstant.paramExeternalData]
            [PocaAlbumConstant.paramAlbumList]
        .toString();
  } on Exception {
    return 'false';
  }
}
