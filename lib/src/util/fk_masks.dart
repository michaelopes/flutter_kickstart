import 'package:easy_mask/easy_mask.dart';

class FkMasks {
  ///To custom mask show DOCS
  ///*on <https://pub.dev/packages/easy_mask>
  static TextInputMask customMask({
    required dynamic mask,
    bool reverse = false,
    int maxLength = -1,
    String placeholder = '',
    int maxPlaceHolders = -1,
  }) {
    return TextInputMask(
      mask: mask,
      reverse: reverse,
      maxLength: maxLength,
      maxPlaceHolders: maxPlaceHolders,
      placeholder: placeholder,
    );
  }

  static TextInputMask get brCellphone => TextInputMask(
        mask: '(99) 9 9999-9999',
      );

  static TextInputMask get brPhone => TextInputMask(
        mask: '(99) 9999-9999',
      );

  static TextInputMask get cep => TextInputMask(
        mask: '99.999-999',
      );

  static TextInputMask get brDate => TextInputMask(
        mask: '99/99/9999',
      );

  static TextInputMask get cpf => TextInputMask(
        mask: '999.999.999-99',
      );

  static TextInputMask get cnpj => TextInputMask(
        mask: '99.999.999/9999-99',
      );

  static TextInputMask get cardNumber => TextInputMask(
        mask: '9999 9999 9999 9999',
      );

  static TextInputMask get cardExpiringDate => TextInputMask(
        mask: '99/99',
      );

  static TextInputMask get money => TextInputMask(
        mask: '9+.999,99',
        placeholder: '0',
        maxPlaceHolders: 3,
        reverse: true,
      );
}

extension TextInputMaskExt on TextInputMask {
  String maskText(String text) {
    return magicMask.getMaskedString(text);
  }
}
