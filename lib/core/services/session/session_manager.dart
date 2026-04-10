class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  bool hasHomeAnimationPlayed = false;

  void reset() {
    hasHomeAnimationPlayed = false;
  }
}
