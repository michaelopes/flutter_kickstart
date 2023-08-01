import 'package:flutter/material.dart';

import '../../flutter_kickstart.dart';
import '../i18n/fk_translate_processor.dart';

extension BuildContextExt on BuildContext {
  GoRouter get nav => GoRouter.of(this);
  dynamic get tr => FkTranslatorProcessor(this);
}
