import 'package:flutter/material.dart';

import '../../flutter_kickstart.dart';
import '../i18n/fk_translate_processor.dart';

extension StateExt on State {
  GoRouter get nav => GoRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);
}
