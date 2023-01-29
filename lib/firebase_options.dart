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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCtXJYFpsSXvNFoPfzoRMTHAQnuJIbEDSA',
    appId: '1:772956890608:web:f210e0f5066e03484ce935',
    messagingSenderId: '772956890608',
    projectId: 'edms-77162',
    authDomain: 'edms-77162.firebaseapp.com',
    storageBucket: 'edms-77162.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDT_BquQPUyxiFIc6-PUrVMnY9z3_TXm9Q',
    appId: '1:772956890608:android:07eb173968ccdfea4ce935',
    messagingSenderId: '772956890608',
    projectId: 'edms-77162',
    storageBucket: 'edms-77162.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdX84as9__8fPCbtf9Cgnhh2snd-JzLj0',
    appId: '1:772956890608:ios:9ddfe97b78766d9a4ce935',
    messagingSenderId: '772956890608',
    projectId: 'edms-77162',
    storageBucket: 'edms-77162.appspot.com',
    iosClientId: '772956890608-1sjk49j1r6idqgok2gj0elasben09u3a.apps.googleusercontent.com',
    iosBundleId: 'com.example.etransport',
  );
}