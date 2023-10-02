// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBIYDPGkspHpX7thJu-MQwPGP1MSzNHnxc',
    appId: '1:411323205761:web:06bc6d0f466cfcc9ee6580',
    messagingSenderId: '411323205761',
    projectId: 'pet-app-d408e',
    authDomain: 'pet-app-d408e.firebaseapp.com',
    storageBucket: 'pet-app-d408e.appspot.com',
    measurementId: 'G-DQ8TL880Y7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5h9l24r86Fl8frSH1USBzIQU1FdLrDSw',
    appId: '1:411323205761:android:d40ad4ea9c2fb669ee6580',
    messagingSenderId: '411323205761',
    projectId: 'pet-app-d408e',
    storageBucket: 'pet-app-d408e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsJnYevNdoEkHojh9sjIAGQ3Q2bl3b0Og',
    appId: '1:411323205761:ios:cc15985c10507e46ee6580',
    messagingSenderId: '411323205761',
    projectId: 'pet-app-d408e',
    storageBucket: 'pet-app-d408e.appspot.com',
    iosBundleId: 'com.example.petApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBsJnYevNdoEkHojh9sjIAGQ3Q2bl3b0Og',
    appId: '1:411323205761:ios:928e3638e50e0f3aee6580',
    messagingSenderId: '411323205761',
    projectId: 'pet-app-d408e',
    storageBucket: 'pet-app-d408e.appspot.com',
    iosBundleId: 'com.example.petApp.RunnerTests',
  );
}