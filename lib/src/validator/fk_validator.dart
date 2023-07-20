import '../util/fk_toolkit.dart';
import 'cnpj_validator.dart';
import 'cpf_validator.dart';
import 'fk_validador_messages.dart';

class FkValidator {
  static FkValidadorMessages validatorMessages = FkValidadorMessages();
  static bool isEmail(String email) {
    return RegExp(
                r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email) &&
        !blockEmoji().hasMatch(email);
  }

  static bool isValidCPF(String document) =>
      document.isEmpty || document.trim().length < 11
          ? true
          : CPFValidator.isValid(document);

  static bool isValidCNPJ(String document) =>
      document.isEmpty || document.trim().length < 14
          ? true
          : CNPJValidator.isValid(document);

  static bool isValidPassword(String? password) =>
      (password == null || password.isEmpty)
          ? true
          : password.trim().length >= 6;

  /// Example:
  /// isValidStringRange("RedBlueGreenGray", "16") = returns true;
  /// isValidStringRange("RedBlueGreenGray", "15") = returns true;
  /// isValidStringRange("RedBlueGreenGray", "4,15") = returns true;
  /// isValidStringRange("RedBlueGreenGray", "4,16") = returns true;
  /// isValidStringRange("RedBlueGreenGray", "0,16") = returns true;
  /// isValidStringRange("RedBlueGreenGray", "17") = returns false;
  /// isValidStringRange("RedBlueGreenGray", "") = returns false;
  static bool isValidStringRange(String? string, String range) {
    var split = range.split(",");
    var min = 0;
    var max = 0;
    if (split.length > 1) {
      min = int.tryParse(split[0]) ?? 0;
      max = int.tryParse(split[1]) ?? 0;
    } else if (split.length == 1) {
      min = 0;
      max = int.tryParse(split[0]) ?? 0;
    } else {
      return false;
    }
    return (string ?? "").trim().length >= min &&
        (string ?? "").trim().length <= max;
  }

  static bool isStrongPassword(String password) =>
      password.length >= 8 &&
      containSpetialChars(password) &&
      containUppercaseLetter(password) &&
      containLowercaseLetter(password);

  static bool isAlfanumeric(String text) {
    return RegExp(r"^[a-zA-Z0-9À-ÖØ-öø-ÿ&\- ]*$").hasMatch(text);
  }

  static bool isVerificationCode(String text) {
    return text.length == 8 && isAlfanumeric(text);
  }

  static bool isName(String text) {
    var splited = text.trim().split(" ");
    if (splited.length == 1) return false;
    return RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ&\- ]*$").hasMatch(text);
  }

  static bool containSpetialChars(String text) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(text);
  }

  static bool containUppercaseLetter(String text) {
    return RegExp(r'[A-Z]').hasMatch(text);
  }

  static bool containLowercaseLetter(String text) {
    return RegExp(r'[a-z]').hasMatch(text);
  }

  static bool containNumber(String text) {
    return RegExp(r'[A-Z]').hasMatch(text);
  }

  static bool isFacebook(String text) {
    if (text.isEmpty) return true;
    return RegExp(r'^(https?://)?(www\.)?facebook\.com/.*$')
        .hasMatch(text.toLowerCase());
  }

  static bool isYoutube(String text) {
    if (text.isEmpty) return true;
    return RegExp(r'^(https?://)?(www\.)?youtube\.com/.*$')
        .hasMatch(text.toLowerCase());
  }

  static bool isDribbble(String text) {
    if (text.isEmpty) return true;
    return RegExp(r'^(https?://)?(www\.)?dribbble\.com/.*$')
        .hasMatch(text.toLowerCase());
  }

  static bool isInstagram(String text) {
    if (text.isEmpty) return true;
    return RegExp(r'^(https?://)?(www\.)?instagram\.com/.*$|(@[a-z]*)')
        .hasMatch(text.toLowerCase());
  }

  static bool isLinkedin(String text) {
    if (text.isEmpty) return true;
    return RegExp(r'^(https?://)?(www\.)?linkedin\.com/.*$')
        .hasMatch(text.toLowerCase());
  }

  static bool isGithub(String text) {
    if (text.isEmpty) return true;
    return RegExp(r'^(https?://)?(www\.)?github\.com/.*$')
        .hasMatch(text.toLowerCase());
  }

  static bool isPhone(String text) {
    var phone = FkToolkit.removeSpecialCharacters(text);
    return phone.length == 11 || phone.length == 10;
  }

  static bool isCellphone(String text) {
    var phone = FkToolkit.removeSpecialCharacters(text).replaceAll(" ", "");
    if (phone.isEmpty) {
      return true;
    }
    return phone.length == 11;
  }

  static RegExp blockEmoji() {
    return RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
  }

  static bool isValidCardCVV(String value) {
    if ((value.length == 3 || value.length == 4)) {
      return true;
    }
    return false;
  }

  static bool isValidCreditCardNumber(String input) {
    if (input.isEmpty) {
      return false;
    }
    input = input.replaceAll(" ", "");
    if (input.length < 8 || input.length > 16) {
      return false;
    }

    var sum = 0;
    var length = input.length;
    for (var i = 0; i < length; i++) {
      var digit = int.parse(input[length - i - 1]);
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return true;
    }
    return false;
  }

  static bool isDateValid(String input) {
    try {
      var dateParts = input.split('-');
      if (dateParts.length != 3) {
        return false;
      }
      var year = int.parse(dateParts[0]);
      var month = int.parse(dateParts[1]);
      var day = int.parse(dateParts[2]);
      if (month < 1 || month > 12) {
        return false;
      }
      var lastDayOfMonth = DateTime(year, month + 1, 0).day;
      if (day < 1 || day > lastDayOfMonth) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isDateGreaterThanNow(String input) {
    try {
      var date = DateTime.parse(input);
      return date.millisecondsSinceEpoch >
          DateTime.now().millisecondsSinceEpoch;
    } catch (e) {
      return false;
    }
  }
}
