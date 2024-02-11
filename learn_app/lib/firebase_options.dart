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
    apiKey: 'AIzaSyAV0v6T3q4Tk6mTq4if0v2rLZcWTHn0gK8',
    appId: '1:785144162989:web:597c3589d92ea99119b424',
    messagingSenderId: '785144162989',
    projectId: 'flutter-learn-app-9168c',
    authDomain: 'flutter-learn-app-9168c.firebaseapp.com',
    storageBucket: 'flutter-learn-app-9168c.appspot.com',
    measurementId: 'G-TM4WFJDVK9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkWiB27zrqsXuMLO0poxSt4DASu-O3I6A',
    appId: '1:785144162989:android:1728d280cef5c2da19b424',
    messagingSenderId: '785144162989',
    projectId: 'flutter-learn-app-9168c',
    storageBucket: 'flutter-learn-app-9168c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDtdWX8SM4-Um5AntRyatysrGlqDcPghk',
    appId: '1:785144162989:ios:b51bed950a05a01719b424',
    messagingSenderId: '785144162989',
    projectId: 'flutter-learn-app-9168c',
    storageBucket: 'flutter-learn-app-9168c.appspot.com',
    iosBundleId: 'com.arthurpasqualon.learnapp.learnApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDtdWX8SM4-Um5AntRyatysrGlqDcPghk',
    appId: '1:785144162989:ios:b96da6ad798ddd7119b424',
    messagingSenderId: '785144162989',
    projectId: 'flutter-learn-app-9168c',
    storageBucket: 'flutter-learn-app-9168c.appspot.com',
    iosBundleId: 'com.arthurpasqualon.learnapp.learnApp.RunnerTests',
  );
}