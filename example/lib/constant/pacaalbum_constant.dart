abstract class PocaAlbumConstant {
  static const String pocaalbumURL = 'https://dev-api.pocaalbum.com/';

  static const String apiBaseURL = "apis/v1/";
  static const String apiAuthPrefix = "Bearer";

  static const String apiGetOwnNfcAlbumListURL =
      'pocaalbum/get_own_nfc_album_list/';

  static const String paramResult = "result";
  static const String paramCode = "code";
  static const String paramExeternalData = "external_data";
  static const String paramAlbumList = "album_list";

  static const int serviceBaseTimeout = 10 * 1000; // 10s
}
