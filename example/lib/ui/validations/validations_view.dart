import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import 'validations_viewmodel.dart';

class ValidationsView extends FkView<ValidationsViewModel> {
  ValidationsView({super.key});

  Widget get _buildRequiredField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Required validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.required),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildMinField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Min 2 validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.min, value: 2),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildMaxField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Max 6 validation field ",
        ),
        initialValue: "12345678",
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.max, value: 6),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildStringRangeField => TextFormField(
        decoration: const InputDecoration(
          labelText: "String Range 2,6 validation field ",
        ),
        initialValue: "12345678",
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.stringRange, value: "2,6"),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildEmailField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Email validation field ",
        ),
        onChanged: (value) {
          vm.email = value;
        },
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isEmail),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildConfirmEmailField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Confirm Email validation field ",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isEmailEquals, value: vm.email),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildStrongPasswordField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Strong Password validation field ",
        ),
        onChanged: (value) {
          vm.password = value;
        },
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isStrongPassword),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildConfirmPasswordField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Confirm Password validation field ",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(
              FkValidateTypes.isPasswordEquals,
              value: vm.password,
            ),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCpfFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CPF validation field",
        ),
        inputFormatters: [
          FkMasks.cpf,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCpf),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCnpjFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CNPJ validation field",
        ),
        inputFormatters: [
          FkMasks.cnpj,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCnpj),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildAlfanumericFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Alfanumeric validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isAlfanumeric),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildNameFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Name validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isName),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildBRPhoneFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "BRPhone validation field",
        ),
        inputFormatters: [
          FkMasks.brPhone,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isBRPhone),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildBRCellphoneField => TextFormField(
        decoration: const InputDecoration(
          labelText: "BRCellphone validation field",
        ),
        inputFormatters: [
          FkMasks.brCellphone,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isBRCellphone),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCardNumberField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CardNumber validation field",
        ),
        inputFormatters: [
          FkMasks.cardNumber,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCardNumber),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCardExpiringDateField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CardExpiringDate validation field",
        ),
        inputFormatters: [
          FkMasks.cardExpiringDate,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCardExpiringDate),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCardCVVField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CardCVV validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCardCVV),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCepField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CEP validation field",
        ),
        inputFormatters: [
          FkMasks.cep,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCep),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildFacebookUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "FacebookUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isFacebookUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildInstagramUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "InstagramUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isInstagramUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildLinkedinUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "LinkedinUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isLinkedinUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildYoutubeUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "YoutubeUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isYoutubeUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildDribbbleUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "DribbbleUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isDribbbleUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildGithubUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "DribbbleUrl, validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isGithubUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildDateField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Date validation field",
        ),
        inputFormatters: [
          FkMasks.brDate,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isDate),
          ];
          var date = FkToolkit.brDatetime2IsoDatetime(value ?? "");
          return FkFieldValidator(rules).validate(date);
        },
      );

  /*
  isGithubUrl,
  isDate,
 */

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Validations and Masks",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: vm.formKey,
            child: Column(
              children: [
                FkResponsiveRow(
                  crossAxisSpacing: FkResponsiveSpacing(
                    sm: 16,
                    lg: 16,
                    md: 16,
                    xl: 16,
                  ),
                  mainAxisSpacing: FkResponsiveSpacing(
                    sm: 16,
                    lg: 16,
                    md: 16,
                    xl: 16,
                  ),
                  children: [
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildRequiredField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildMinField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildMaxField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildStringRangeField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildEmailField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildConfirmEmailField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildStrongPasswordField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildConfirmPasswordField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCpfFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCnpjFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildAlfanumericFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildNameFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildBRPhoneFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildBRCellphoneField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCardNumberField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCardExpiringDateField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCardCVVField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCepField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildFacebookUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildInstagramUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildLinkedinUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildYoutubeUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildDribbbleUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildGithubUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildDateField,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: vm.submit,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
