import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService extends ChangeNotifier {
  bool loggedIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String? getUserId() {
    return _auth.currentUser!.uid;
  }

  String? getUserEmail() {
    return _auth.currentUser!.email;
  }

  signOutUser() {
    _auth.signOut();
  }

  checkIfLoggedIn() {
    _auth.authStateChanges().listen((User? user) {
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
