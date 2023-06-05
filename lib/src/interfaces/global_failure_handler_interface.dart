import 'package:flutter/widgets.dart';

abstract class IGlobalFailureHandler {
  void onFailure(BuildContext context, Object error, StackTrace stackTrace);
}
