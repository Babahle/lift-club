import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService extends ChangeNotifier{
  bool loggedIn = false;

  checkIfLoggedIn() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        loggedIn = false;
      } else {
        loggedIn = true;
      }
      notifyListeners();
    });
    return loggedIn;

  }
}
