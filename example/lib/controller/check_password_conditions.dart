//비밀번호 조건 체크
class CheckPassword {
  String password;

  CheckPassword(this.password);

  static final RegExp englishRegExp = RegExp(r"[a-zA-Z]");
  static final RegExp numberRegExp = RegExp(r"(\d+)");
  static final RegExp specialCharRegExp = RegExp(r"[!@#$%^&*]");

  bool isHaveEnglish() {
    if (englishRegExp.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isHaveNumber() {
    if (numberRegExp.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isHaveSpecialChar() {
    if (specialCharRegExp.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isHave8Char() {
    if (password.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  bool isHaveAll() {
    return isHaveNumber() &&
        isHaveEnglish() &&
        isHaveSpecialChar() &&
        isHave8Char();
  }
}
