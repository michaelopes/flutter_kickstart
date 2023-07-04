class FkValidadorMessages {
  late final String invalidEmail;
  late final String requiredField;
  late final String invalidName;
  late final String invalidAlfanumeric;
  late final String maxAge;
  late final String minAge;
  late final String invalidCpf;
  late final String invalidCnpj;
  late final String invalidMinCharacter;
  late final String invalidMaxCharacter;
  late final String invalidMaxNumber;
  late final String invalidMinNumber;
  late final String invalidStringRange;
  late final String invalidCardNumber;
  late final String invalidCardExpiringDate;
  late final String invalidCardCvv;
  late final String invalidFacebookUrl;
  late final String invalidInstagramUrl;
  late final String invalidLinkedinUrl;
  late final String invalidYoutubeUrl;
  late final String invalidGithubUrl;
  late final String invalidDribbbleUrl;
  late final String passwordDiff;
  late final String emailDiff;
  late final String invalidBRCellphone;
  late final String invalidBRPhone;
  late final String invalidCep;
  late final String invalidDate;
  late final String invalidDateGreaterThanNow;
  late final String invalidStrongPassword;

  FkValidadorMessages({
    String? invalidEmail,
    String? requiredField,
    String? invalidName,
    String? invalidAlfanumeric,
    String? maxAge,
    String? minAge,
    String? invalidCpf,
    String? invalidCnpj,
    String? invalidMinCharacter,
    String? invalidMaxCharacter,
    String? invalidMaxNumber,
    String? invalidMinNumber,
    String? invalidStringRange,
    String? invalidCardNumber,
    String? invalidCardExpiringDate,
    String? invalidCardCvv,
    String? invalidFacebookUrl,
    String? invalidInstagramUrl,
    String? invalidLinkedinUrl,
    String? invalidYoutubeUrl,
    String? invalidGithubUrl,
    String? invalidDribbbleUrl,
    String? passwordDiff,
    String? emailDiff,
    String? invalidBRCellphone,
    String? invalidBRPhone,
    String? invalidCep,
    String? invalidDate,
    String? invalidDateGreaterThanNow,
    String? invalidStrongPassword,
  }) {
    this.invalidEmail = invalidEmail ?? "Invalid e-mail!";
    this.requiredField = requiredField ?? "This field is required!";
    this.invalidName = invalidName ?? "Invalid name!";
    this.invalidAlfanumeric = invalidAlfanumeric ?? "Invalid alfanumeric!";
    this.maxAge = maxAge ?? "Maximum age {{p1}} years!";
    this.minAge = minAge ?? "Minimum age {{p1}} years!";
    this.invalidCpf = invalidCpf ?? "Invalid CPF!";
    this.invalidCnpj = invalidCnpj ?? "Invalid CNPJ!";
    this.invalidMinCharacter = invalidMinCharacter ??
        "This field must have at least {{p1}} character(s)!";
    this.invalidMaxCharacter = invalidMaxCharacter ??
        "This field must have a maximum of {{p1}} character(s)!";
    this.invalidMaxNumber =
        invalidMaxNumber ?? "Number must be less than or equal to {{p1}}!";
    this.invalidMinNumber =
        invalidMinNumber ?? "Number must be greater than or equal to {{p1}}!";
    this.invalidCardNumber = invalidCardNumber ?? "Invalid card number!";
    this.invalidCardExpiringDate =
        invalidCardExpiringDate ?? "Invalid expiration date!";
    this.invalidCardCvv = invalidCardCvv ?? "Enter a valid CVV!";
    this.invalidFacebookUrl = invalidFacebookUrl ?? "Invalid Facebook link!";
    this.invalidInstagramUrl = invalidInstagramUrl ?? "Invalid Instagram link!";
    this.invalidLinkedinUrl = invalidLinkedinUrl ?? "Invalid LinkedIn link!";
    this.invalidYoutubeUrl = invalidYoutubeUrl ?? "Invalid YouTube link!";
    this.invalidGithubUrl = invalidGithubUrl ?? "Invalid GitHub link!";
    this.invalidDribbbleUrl = invalidDribbbleUrl ?? "Invalid Dribbble link!";
    this.passwordDiff = passwordDiff ?? "The entered passwords are differen!";
    this.emailDiff = emailDiff ?? "The entered e-mails are differen!";
    this.invalidBRCellphone = invalidBRCellphone ?? "Invalid Cellphone!";
    this.invalidCep = invalidCep ?? "Invalid CEP!";
    this.invalidDate = invalidDate ?? "Invalid date!";
    this.invalidDateGreaterThanNow =
        invalidDateGreaterThanNow ?? "Entered date must be greater than today!";
    this.invalidStrongPassword =
        invalidStrongPassword ?? "Password entered is weak!";
    this.invalidStringRange =
        invalidStringRange ?? "Value must be {{p1}} to {{p2}} characters long!";
    this.invalidBRPhone = invalidBRPhone ?? "Invalid phone!";
  }
}
