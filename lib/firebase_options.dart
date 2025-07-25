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
    apiKey: 'AIzaSyBIwtsA8wprvQAMVhA2ximTzEbnRcKsdUY',
    appId: '1:709239543412:web:438deb16ad22936f30e321',
    messagingSenderId: '709239543412',
    projectId: 'travelapp-ab6fc',
    authDomain: 'travelapp-ab6fc.firebaseapp.com',
    storageBucket: 'travelapp-ab6fc.appspot.com',
    measurementId: 'G-1G5QW4MM70',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPfR9L7TciwIdkEY8QUdy3PYaQ4PX51RQ',
    appId: '1:709239543412:android:304115222451b32f30e321',
    messagingSenderId: '709239543412',
    projectId: 'travelapp-ab6fc',
    storageBucket: 'travelapp-ab6fc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQ3PgUpPgs3rBb0sA0SSPfA156c5fIPqc',
    appId: '1:709239543412:ios:8f58f1f035fff58230e321',
    messagingSenderId: '709239543412',
    projectId: 'travelapp-ab6fc',
    storageBucket: 'travelapp-ab6fc.appspot.com',
    iosBundleId: 'com.example.travelapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQ3PgUpPgs3rBb0sA0SSPfA156c5fIPqc',
    appId: '1:709239543412:ios:c92bfe8e4ff6b6db30e321',
    messagingSenderId: '709239543412',
    projectId: 'travelapp-ab6fc',
    storageBucket: 'travelapp-ab6fc.appspot.com',
    iosBundleId: 'com.example.travelapp.RunnerTests',
  );
}
