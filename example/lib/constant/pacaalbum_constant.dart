abstract class PocaAlbumConstant {
  static const String pocaalbumURL = 'https://dev-api.pocaalbum.com/';

  static const String apiBaseURL = "apis/v1/";
  static const String apiAuthPrefix = "Bearer";

  static const String apiGetOwnNfcAlbumListURL =
      'pocaalbum/get_own_nfc_album_list/';
  static const String apiGetOwnAlbumListInfoURL =
      'pocaalbum/get_own_album_list_info/';
  static const String apiGetNfcAlbumVideoURL = 'nfc/get_nfc_album_video/';

  static const String paramResult = "result";
  static const String paramCode = "code";
  static const String paramExeternalData = "external_data";
  static const String paramAlbumList = "album_list";

  static const String paramId = 'id';
  static const String paramIndex = 'index';
  static const String paramTitle = 'title';
  static const String paramVersionCode = 'version_code';
  static const String paramReleasedAt = 'released_at';
  static const String paramArtist = 'artist';
  static const String paramName = 'name';
  static const String paramPublishedAlbumList = 'published_album_list';
  static const String paramAlbumType = 'album_type';
  static const String paramNfcImageID = 'nfc_image_id';
  static const String paramNfcImageURL = 'nfc_image_url';
  static const String paramBoxIMageURL = 'box_image_url';
  static const String paramUUId = 'uuid';

  static const String paramNfcID = 'nfc_id';
  static const String paramVideoList = 'video_list';
  static const String paramYoutubeList = 'youtube_list';
  static const String paramVideoType = 'video_type';
  static const String paramAlbum = 'album';
  static const String paramMusic = 'music';
  static const String paramIsTitle = 'is_title';
  static const String paramMemberList = 'member_list';
  static const String paramBornAt = 'born_at';
  static const String paramBloodType = 'blood_type';
  static const String paramHeight = 'height';
  static const String paramWeight = 'weight';
  static const String paramPosition = 'position';
  static const String paramSiteInfo = 'site_info';
  static const String paramTwitter = 'twitter';
  static const String paramYouTube = 'youtube';
  static const String paramFanClub = 'fan_club';
  static const String paramHomePage = 'homepage';
  static const String paramInstagram = 'instagram';
  static const String paramCreatedAt = 'created_at';
  static const String paramThumbnail = 'thumbnail';
  static const String paramFileName = 'filename';
  static const String paramThumbURL = 'thumb_url';
  static const String paramThumbSize = 'thumb_size';
  static const String paramMime = 'mime';
  static const String paramYouTubeID = 'youtube_id';
  static const String paramLength = 'length';
  static const String paramLengthString = 'length_string';
  static const String paramLikeCount = 'like_count';

  static const int serviceBaseTimeout = 10 * 1000; // 10s
}
