import 'package:flutter/material.dart';
import '../util/toolkit.dart';
import 'card_expiring_date_validator.dart';
import 'cnpj_validator.dart';
import 'cpf_validator.dart';
import 'fk_validator.dart';

enum FkValidateTypes {
  required,
  min,
  max,
  maxAge,
  minAge,
  stringRange,
  dateGreaterThanNow,
  isEmail,
  isStrongPassword,
  isPasswordEquals,
  isEmailEquals,
  isCpf,
  isCnpj,
  isCpfOrCnpj,
  isAlfanumeric,
  isName,
  isBRPhone,
  isBRCellphone,
  isCardNumber,
  isCardExpiringDate,
  isCardCVV,
  isCep,
  isFacebookUrl,
  isInstagramUrl,
  isLinkedinUrl,
  isYoutubeUrl,
  isDribbbleUrl,
  isGithubUrl,
  isDate,
}

class FkValidateRule {
  final FkValidateTypes validateTypes;
  final dynamic value;
  final String? errorMessage;

  FkValidateRule(this.validateTypes, {this.value, this.errorMessage});
}

class FkFieldValidator {
  final List<FkValidateRule> validations;
  final BuildContext context;

  FkFieldValidator(this.validations, this.context);

  String? validate(dynamic value) {
    String? result;

    for (var i = 0; i < validations.length; i++) {
      var validateRule = validations.elementAt(i);

      var key = validateRule.validateTypes;
      var valueRule = validateRule.value;
      var errorMessage = validateRule.errorMessage;

      switch (key) {
        case FkValidateTypes.required:
          {
            if (value == null || value.toString().trim().isEmpty) {
              result =
                  errorMessage ?? FkValidator.validatorMessages.requiredField;
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isStrongPassword:
          {
            var isStrong = FkValidator.isStrongPassword(value);
            if (!isStrong) {
              result = errorMessage ??
                  FkValidator.validatorMessages.invalidStrongPassword;
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.stringRange:
          {
            var isValid =
                FkValidator.isValidStringRange(value, valueRule ?? "");
            if (!isValid) {
              var min = 0;
              var max = 0;
              if (valueRule != null) {
                if (valueRule.length > 1) {
                  min = int.tryParse(valueRule[0]) ?? 0;
                  max = int.tryParse(valueRule[1]) ?? 0;
                } else if (valueRule.length == 1) {
                  min = 0;
                  max = int.tryParse(valueRule[0]) ?? 0;
                }
              }
              result = (errorMessage ??
                      FkValidator.validatorMessages.invalidStringRange)
                  .replaceAll("{{p1}}", min.toString())
                  .replaceAll("{{p2}}", max.toString());
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isAlfanumeric:
          {
            var isValid = FkValidator.isAlfanumeric(value);
            if (!isValid) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidAlfanumeric);
            } else {
              result = null;
            }
            break;
          }

        case FkValidateTypes.isName:
          {
            var isValid = FkValidator.isName(value);
            if (!isValid) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.invalidName);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isBRPhone:
          {
            var isValid = FkValidator.isPhone(value);
            if (!isValid) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidBRPhone);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isBRCellphone:
          {
            var isValid = FkValidator.isCellphone(value);
            if (!isValid) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidBRCellphone);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isPasswordEquals:
          {
            var pass = value.toString();
            var confirm = valueRule.toString();
            var isValid = pass == confirm;
            if (!isValid) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.passwordDiff);
            } else {
              result = null;
            }
            break;
          }

        case FkValidateTypes.isEmailEquals:
          {
            var pass = value.toString();
            var confirm = valueRule.toString();

            var isValid = pass == confirm;
            if (!isValid) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.emailDiff);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isEmail:
          {
            var emailValid = FkValidator.email(value.toString());
            if (!emailValid) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.invalidEmail);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isCpf:
          {
            if (!CPFValidator.isValid(value.toString())) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.invalidCpf);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isCnpj:
          {
            if (!CNPJValidator.isValid(value.toString())) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.invalidCnpj);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isCpfOrCnpj:
          {
            var text = Toolkit.removeSpecialCharacters(value.toString());
            if (text.length == 11) {
              if (!CPFValidator.isValid(value.toString())) {
                result =
                    (errorMessage ?? FkValidator.validatorMessages.invalidCpf);
              } else {
                result = null;
              }
            } else {
              if (!CNPJValidator.isValid(value.toString())) {
                result =
                    (errorMessage ?? FkValidator.validatorMessages.invalidCnpj);
              } else {
                result = null;
              }
            }
            break;
          }
        case FkValidateTypes.isCardNumber:
          {
            if (!FkValidator.isValidCreditCardNumber(value.toString())) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidCardNumber);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isCardCVV:
          {
            if (!FkValidator.isValidCardCVV(value.toString())) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidCardCvv);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isCardExpiringDate:
          {
            if (!CardExpiringDateValidator.isValid(value.toString())) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidCardExpiringDate);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.max:
          {
            if (value.runtimeType == int || value.runtimeType == double) {
              if (value > valueRule) {
                result = (errorMessage ??
                        FkValidator.validatorMessages.invalidMaxNumber)
                    .replaceAll("{{p1}}", valueRule.toString());
              } else {
                result = null;
              }
            } else if (value.runtimeType == String) {
              if (value.toString().length > valueRule) {
                result = (errorMessage ??
                        FkValidator.validatorMessages.invalidMaxCharacter)
                    .replaceAll("{{p1}}", valueRule.toString());
              } else {
                result = null;
              }
            } else {
              result = (errorMessage ??
                      FkValidator.validatorMessages.invalidMaxCharacter)
                  .replaceAll("{{p1}}", valueRule.toString());
            }
            break;
          }
        case FkValidateTypes.maxAge:
          {
            var val = int.parse(value);

            if (val > valueRule) {
              result = (errorMessage ?? FkValidator.validatorMessages.maxAge)
                  .replaceAll("{{p1}}", valueRule.toString());
            } else {
              result = null;
            }

            break;
          }
        case FkValidateTypes.minAge:
          {
            var val = int.parse(value);
            if (valueRule > val) {
              result = (errorMessage ?? FkValidator.validatorMessages.minAge)
                  .replaceAll("{{p1}}", valueRule.toString());
            } else {
              result = null;
            }

            break;
          }
        case FkValidateTypes.min:
          {
            if (value.runtimeType == int || value.runtimeType == double) {
              if (value < valueRule) {
                result = (errorMessage ??
                        FkValidator.validatorMessages.invalidMinNumber)
                    .replaceAll("{{p1}}", valueRule.toString());
              } else {
                result = null;
              }
            } else if (value.runtimeType == String) {
              if (value.toString().length < valueRule) {
                result = (errorMessage ??
                        FkValidator.validatorMessages.invalidMaxCharacter)
                    .replaceAll("{{p1}}", valueRule.toString());
              } else {
                result = null;
              }
            } else {
              result = (errorMessage ??
                      FkValidator.validatorMessages.invalidMaxCharacter)
                  .replaceAll("{{p1}}", valueRule.toString());
            }
            break;
          }
        case FkValidateTypes.isCep:
          {
            if (value.toString().isEmpty) return null;
            if (value.length != 10) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.invalidCep);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isFacebookUrl:
          {
            if (!FkValidator.isFacebook(value)) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidFacebookUrl);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isInstagramUrl:
          {
            if (!FkValidator.isInstagram(value)) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidInstagramUrl);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isLinkedinUrl:
          {
            if (!FkValidator.isLinkedin(value)) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidLinkedinUrl);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isYoutubeUrl:
          {
            if (!FkValidator.isYoutube(value)) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidYoutubeUrl);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isDribbbleUrl:
          {
            if (!FkValidator.isDribbble(value)) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidDribbbleUrl);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isGithubUrl:
          {
            if (!FkValidator.isGithub(value)) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidGithubUrl);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.isDate:
          {
            if (!FkValidator.isDateValid(value)) {
              result =
                  (errorMessage ?? FkValidator.validatorMessages.invalidDate);
            } else {
              result = null;
            }
            break;
          }
        case FkValidateTypes.dateGreaterThanNow:
          {
            if (!FkValidator.isDateGreaterThanNow(value)) {
              result = (errorMessage ??
                  FkValidator.validatorMessages.invalidDateGreaterThanNow);
            } else {
              result = null;
            }
            break;
          }
        default:
          {
            result = null;
            break;
          }
      }
      if (result != null && result != "") {
        break;
      }
    }

    return result;
  }
}
