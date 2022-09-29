import 'package:dio/dio.dart' as dio;

import '../constant/pacaalbum_constant.dart';
import '../controller/pocaalbum_api.dart';

class OwnAlbumListInfoData {
  final int ownAlbumID;
  final String ownAlbumTitle;
  final String ownAlbumReleasedAt;
  final String ownAlbumArtistName;
  final String ownAlbumBoxImageURL;

  OwnAlbumListInfoData(
      this.ownAlbumID,
      this.ownAlbumTitle,
      this.ownAlbumReleasedAt,
      this.ownAlbumArtistName,
      this.ownAlbumBoxImageURL);
}

Future<List<OwnAlbumListInfoData>> getOwnAlbumListInfo() async {
  PocaalbumAPIRequset pocaApiRequest = await (PocaalbumAPIRequsetBuilder(
          PocaAlbumConstant.apiGetOwnAlbumListInfoURL, 'GET')
        ..withIdentification())
      .build();
  try {
    dio.Response response = await pocaApiRequest.send();
    final jsonData = response.data;

    List<OwnAlbumListInfoData> ownAlbumListInfo = [];

    for (var albumList in jsonData[PocaAlbumConstant.paramAlbumList]) {
      ownAlbumListInfo.add(OwnAlbumListInfoData(
          albumList[PocaAlbumConstant.paramId],
          albumList[PocaAlbumConstant.paramTitle],
          albumList[PocaAlbumConstant.paramReleasedAt],
          albumList[PocaAlbumConstant.paramArtist][PocaAlbumConstant.paramName],
          albumList[PocaAlbumConstant.paramPublishedAlbumList][0]
              [PocaAlbumConstant.paramBoxIMageURL]));
      //debugPrint(albumList[PocaAlbumConstant.paramPublishedAlbumList][0][PocaAlbumConstant.paramBoxIMageURL].toString());
    }
    //debugPrint(ownAlbumListInfo[0].ownAlbumArtistName);
    return ownAlbumListInfo;
  } on Exception {
    return [];
  }
}
