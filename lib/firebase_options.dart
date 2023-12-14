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
    apiKey: 'AIzaSyAQJaiXkg74IVGiz2V0IIpnFl2LgPzwy34',
    appId: '1:104377366523:web:a9d908b31680548981fd5e',
    messagingSenderId: '104377366523',
    projectId: 'carikopipbl',
    authDomain: 'carikopipbl.firebaseapp.com',
    storageBucket: 'carikopipbl.appspot.com',
    measurementId: 'G-LER5L7B8B4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkJNlLnqwpOfvqdJk4lKaUORQP1aKL7Ts',
    appId: '1:104377366523:android:1d5b5f4b67e2001c81fd5e',
    messagingSenderId: '104377366523',
    projectId: 'carikopipbl',
    storageBucket: 'carikopipbl.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0BENCoy2l0XBb-lli-odTzZtUk5HCJ0w',
    appId: '1:104377366523:ios:e26a326cf5daddce81fd5e',
    messagingSenderId: '104377366523',
    projectId: 'carikopipbl',
    storageBucket: 'carikopipbl.appspot.com',
    iosBundleId: 'com.example.coffeFinder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0BENCoy2l0XBb-lli-odTzZtUk5HCJ0w',
    appId: '1:104377366523:ios:f7dc292d4d8726a481fd5e',
    messagingSenderId: '104377366523',
    projectId: 'carikopipbl',
    storageBucket: 'carikopipbl.appspot.com',
    iosBundleId: 'com.example.coffeFinder.RunnerTests',
  );
}
