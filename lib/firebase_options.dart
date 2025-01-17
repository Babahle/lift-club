// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC0V8AcgzKQnw1uCgICQtpW4TbbykIDLRA',
    appId: '1:746133285296:web:1012e4d473bc4a56164e75',
    messagingSenderId: '746133285296',
    projectId: 'wtc-final-project',
    authDomain: 'wtc-final-project.firebaseapp.com',
    storageBucket: 'wtc-final-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_v07DzD3SUJH9CWAj8I9kdKesnsLRdW8',
    appId: '1:746133285296:android:2019ed4c9a262183164e75',
    messagingSenderId: '746133285296',
    projectId: 'wtc-final-project',
    storageBucket: 'wtc-final-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHw7K2RujtIMIOQoKmdB-QY8cp9y_GRTA',
    appId: '1:746133285296:ios:c28aa96cc295e3c9164e75',
    messagingSenderId: '746133285296',
    projectId: 'wtc-final-project',
    storageBucket: 'wtc-final-project.appspot.com',
    iosClientId: '746133285296-4o7nt3i91i6jhpgcb704cg4t4s1g4vp8.apps.googleusercontent.com',
    iosBundleId: 'za.co.wethinkcode.widgetsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHw7K2RujtIMIOQoKmdB-QY8cp9y_GRTA',
    appId: '1:746133285296:ios:c28aa96cc295e3c9164e75',
    messagingSenderId: '746133285296',
    projectId: 'wtc-final-project',
    storageBucket: 'wtc-final-project.appspot.com',
    iosClientId: '746133285296-4o7nt3i91i6jhpgcb704cg4t4s1g4vp8.apps.googleusercontent.com',
    iosBundleId: 'za.co.wethinkcode.widgetsApp',
  );

}