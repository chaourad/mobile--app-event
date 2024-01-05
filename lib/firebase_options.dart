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
    apiKey: 'AIzaSyBdBjMyCMPq0uGcnsniEIWk4lQdvI7823w',
    appId: '1:444900169713:web:1ebcd2fa26862c68435650',
    messagingSenderId: '444900169713',
    projectId: 'planification-enements-sportif',
    authDomain: 'planification-enements-sportif.firebaseapp.com',
    storageBucket: 'planification-enements-sportif.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_zDxPen9jpVkWJXHrQ6gZTnb9PCOJzZ8',
    appId: '1:444900169713:android:757ddc1fbcf9b0a0435650',
    messagingSenderId: '444900169713',
    projectId: 'planification-enements-sportif',
    storageBucket: 'planification-enements-sportif.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwdCgMVHg1g41rhQKRZRFY4F3lzD85hU4',
    appId: '1:444900169713:ios:b987560e2fe841dd435650',
    messagingSenderId: '444900169713',
    projectId: 'planification-enements-sportif',
    storageBucket: 'planification-enements-sportif.appspot.com',
    iosBundleId: 'com.example.evenmtSportif',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwdCgMVHg1g41rhQKRZRFY4F3lzD85hU4',
    appId: '1:444900169713:ios:f4d5e1dee5dcc188435650',
    messagingSenderId: '444900169713',
    projectId: 'planification-enements-sportif',
    storageBucket: 'planification-enements-sportif.appspot.com',
    iosBundleId: 'com.example.evenmtSportif.RunnerTests',
  );
}