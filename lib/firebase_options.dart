// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDHNWoshBYJP1ViYg0MbTghL9yE6yf4NJ0',
    appId: '1:518924378219:web:b5efa76cf9237d27ed112e',
    messagingSenderId: '518924378219',
    projectId: 'barberboss-3ca36',
    authDomain: 'barberboss-3ca36.firebaseapp.com',
    storageBucket: 'barberboss-3ca36.appspot.com',
    measurementId: 'G-WV6D7Q8WTE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCecNoBWtztMEGPYJ0tDDzoxrcSkImiSVI',
    appId: '1:518924378219:android:a8a2c73a86f3bbc6ed112e',
    messagingSenderId: '518924378219',
    projectId: 'barberboss-3ca36',
    storageBucket: 'barberboss-3ca36.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqOjikJrU1cZMHoXi5XCXHxrOiitbOUEQ',
    appId: '1:518924378219:ios:35ef17f60cf38b4fed112e',
    messagingSenderId: '518924378219',
    projectId: 'barberboss-3ca36',
    storageBucket: 'barberboss-3ca36.appspot.com',
    iosBundleId: 'com.example.salonbuddy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqOjikJrU1cZMHoXi5XCXHxrOiitbOUEQ',
    appId: '1:518924378219:ios:35ef17f60cf38b4fed112e',
    messagingSenderId: '518924378219',
    projectId: 'barberboss-3ca36',
    storageBucket: 'barberboss-3ca36.appspot.com',
    iosBundleId: 'com.example.salonbuddy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDHNWoshBYJP1ViYg0MbTghL9yE6yf4NJ0',
    appId: '1:518924378219:web:a987049fccc08227ed112e',
    messagingSenderId: '518924378219',
    projectId: 'barberboss-3ca36',
    authDomain: 'barberboss-3ca36.firebaseapp.com',
    storageBucket: 'barberboss-3ca36.appspot.com',
    measurementId: 'G-05K8CTSPGY',
  );

}