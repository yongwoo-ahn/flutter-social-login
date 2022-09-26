//import 'package:pocaalbum/utils/constant/service_constant.dart';

enum CodeMail { certify, resetPassword }

enum Social { twitter, kakao, facebook, google, naver, apple, makestar }

enum LoginResult { success, notCertified, failure }

enum SocialLoginResult { success, emailNotFound, sameObjectExist, failure }

enum ValidateType { email, certifyCode, password, notEmpty }

abstract class AuthConstant {
  /*static const String accountURL = ServiceConstant.isProduction
      ? "https://auth.makestar.com/"
      : "https://auth-dev.makestar.com/";*/

  static const String accountURL = "https://auth-dev.makestar.com/";

  static const String apiBaseURL = "apis/v1/";
  static const String apiAuthPrefix = "Bearer";

  static const String naverLoginURL = "https://openapi.naver.com/v1/nid/me";

  static const String apiLoginURL = "user/account/signin_with_email/";
  static const String apiJoinURL = "user/account/signup_with_email/";
  static const String apiTokenRefreshURL = "user/account/refresh_token/";

  static const String apiSendCertificationCodeURL =
      "user/account/send_verification_code/";
  static const String apiChangePasswordURL = "user/account/change_password/";
  static const String apiSendResetPasswordCodeURL =
      "user/account/send_reset_password_code/";
  static const String apiCheckIsAvailableCodeURL =
      "user/account/is_available_code/";
  static const String apiCertifyUserURL = "user/account/verify_email/";
  static const String apiResetPasswordURL = "user/account/reset_password/";
  static const String apiIsRegisteredEmailURL =
      "user/account/is_registered_email/";
  static const String apiCheckSocialId =
      "user/account/is_registered_social_account/";
  static const String apiSocialCertifiedJoinURL =
      "user/account/signup_with_social_account/";
  static const String apiSocialLoginURL =
      "user/account/signin_with_social_account/";
  static const String apiUpdateUserProfileURL =
      "user/profile/update_user_profile/";
  static const String apiGetUserProfileURL = "user/get_user_profile/";
  static const String apiGetUserProfileImageURL = "user/profile/image/";
  static const String apiGetUserProfileUploadInfoURL =
      "user/get_user_profile_image_upload_info/";
  static const String apiAddUserProfileImageInfoURL =
      "user/add_user_profile_image_info/";
  static const String apiResetUserProfileImageURL =
      "user/reset_user_profile_image/";
  static const String apiWithdraw = "user/profile/withdraw/";

  static const String paramProvider = "provider";
  static const String paramName = "name";
  static const String paramEmail = "email";
  static const String paramPassword = "password";
  static const String paramBirthDay = "birthday";
  static const String paramAccessTokenShort = "access";
  static const String paramAccessToken = "access_token";
  static const String paramRefreshTokenShort = "refresh";
  static const String paramRefreshToken = "refresh_token";
  static const String paramCode = "code";
  static const String paramCodeType = "code_type";
  static const String paramCodeTypeEmail = "EMAIL_VERIFICATION";
  static const String paramCodeTypePassword = "PASSWORD_RESET";
  static const String paramResult = "result";
  static const String paramSocialProvider = "social_provider";
  static const String paramSocialType = "social_type";
  static const String paramSocialId = "social_id";
  static const String paramSocialData = "social_data";
  static const String paramOldPassword = "old_password";
  static const String paramNewPassword = "new_password";
  static const String paramSocialResult = "social_result";
  static const String paramUserInformation = "userinformation";
  static const String paramProfileImage = "profile_image";
  static const String paramThumbUrl = "thumb_url";

  static const String paramUser = "user";
  static const String paramFilename = "filename";
  static const String paramFileExtension = "extension";
  static const String paramMime = "mime";
  static const String paramOrigin = "origin";
  static const String paramProductList = "product_list";
  static const String paramUrl = "url";
  static const String paramImage = "image";
  static const String paramExternalData = "external_data";
  static const String paramMode = "mode";
  static const String paramPage = "page";
  static const String paramSize = "size";
  static const String paramWidth = "width";
  static const String paramHeight = "height";

  static const String errorCodeNotCertified = "user_is_not_certified_exception";
  static const String responseCodeSameObjectExist =
      'same_object_exist_exception';
  static const String responseCodeNotCertified =
      'user_is_not_certified_exception';
  static const String responseCodePasswordIncorrect =
      "password_is_incorrect_exception";
  static const String responseCodeObjectDoesNotExist =
      "object_does_not_exist_exception";

  static const List socialProviderList = [
    "MAKESTAR",
    "GOOGLE",
    "TWITTER",
    "FACEBOOK",
    "APPLE",
    "KAKAO",
    "NAVER"
  ];
  static const int makestar = 0;
  static const int google = 1;
  static const int twitter = 2;
  static const int facebook = 3;
  static const int apple = 4;
  static const int kakao = 5;
  static const int naver = 6;

  static const int serviceBaseTimeout = 10 * 1000; // 10s
}
