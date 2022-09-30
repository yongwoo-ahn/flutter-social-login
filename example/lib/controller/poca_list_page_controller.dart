import 'package:dio/dio.dart' as dio;

import '../constant/pacaalbum_constant.dart';
import '../controller/pocaalbum_api.dart';

class OwnAlbumListInfoData {
  final int ownAlbumID;
  final String ownAlbumTitle;
  final String ownAlbumReleasedAt;
  final String ownAlbumArtistName;
  final String ownAlbumBoxImageURL;
  final String ownAlbumUUID;

  OwnAlbumListInfoData(
      this.ownAlbumID,
      this.ownAlbumTitle,
      this.ownAlbumReleasedAt,
      this.ownAlbumArtistName,
      this.ownAlbumBoxImageURL,
      this.ownAlbumUUID);
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
            [PocaAlbumConstant.paramBoxIMageURL],
        albumList[PocaAlbumConstant.paramPublishedAlbumList][0]
            [PocaAlbumConstant.paramUUId],
      ));
    }

    //debugPrint(ownAlbumListInfo[0].ownAlbumArtistName);
    return ownAlbumListInfo;
  } on Exception {
    return [];
  }
}

class NfcAlbumVideo {
  final int id;
  final String youtubeTitle;
  final String youtubeThumbnailURL;
  final String youtubeID;

  NfcAlbumVideo(
      this.id, this.youtubeTitle, this.youtubeThumbnailURL, this.youtubeID);
}

Future<List<NfcAlbumVideo>> getNfcAlbumVideo(String nfcID) async {
  PocaalbumAPIRequset pocaApiRequest = await (PocaalbumAPIRequsetBuilder(
          PocaAlbumConstant.apiGetNfcAlbumVideoURL, 'POST')
        ..withBodyData({
          PocaAlbumConstant.paramNfcID: nfcID,
        }))
      .build();
  try {
    dio.Response response = await pocaApiRequest.send();
    final jsonData = response.data;

    List<NfcAlbumVideo> nfcAlbumVideo = [];

    for (var videoList in jsonData[PocaAlbumConstant.paramYoutubeList]) {
      nfcAlbumVideo.add(NfcAlbumVideo(
          videoList[PocaAlbumConstant.paramId],
          videoList[PocaAlbumConstant.paramTitle],
          videoList[PocaAlbumConstant.paramThumbnail]
              [PocaAlbumConstant.paramThumbURL],
          videoList[PocaAlbumConstant.paramYouTubeID]));
    }

    //debugPrint(nfcAlbumVideo[0].youtubeID);
    return nfcAlbumVideo;
  } on Exception {
    return [];
  }
}
