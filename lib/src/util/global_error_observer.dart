typedef StateObsListener = Function(Object state, StackTrace stackTrace);

class GlobalErrorObserver {
  static StateObsListener? _listener;
  static set listen(StateObsListener listener) => _listener = listener;
  static bool get canAddListener => _listener == null;

  static void dispatch(Object error, StackTrace stackTrace) {
    if (_listener != null) {
      _listener!(error, stackTrace);
    }
  }
}
