import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class LoginState with ChangeNotifier {
  static Status _status = Status.Unauthenticated;

  // LoginState.instance() :  _pawAuth = PawAuth(){
  //   auth.onAuthStateChanged.listen(_onAuthStateChanged);
  // }
  LoginState.instance();

  Status get status => _status;

  Future<bool> signIn(String parentId, String password) async {
    _status = Status.Authenticated;
    notifyListeners();
    return true;
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
  }
}
