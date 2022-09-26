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
