
  bool _isLoggedIn = false;
  String userid='';
  bool get isLoggedIn => _isLoggedIn;
  String get UserID => userid;

  void login(String email) {
    _isLoggedIn = true;
    userid= email;
  }

  void logout() {
    _isLoggedIn = false;
  }

