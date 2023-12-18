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
    apiKey: 'AIzaSyAbWv0Q2uSUR-6bo0NvN-9OfOOBlH1OeSg',
    appId: '1:853473479331:web:9b885e14b65131d2760d16',
    messagingSenderId: '853473479331',
    projectId: 'mobilcihazlar-2a280',
    authDomain: 'mobilcihazlar-2a280.firebaseapp.com',
    storageBucket: 'mobilcihazlar-2a280.appspot.com',
    measurementId: 'G-V14CWSZ550',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNFdY-7m2tuLrnAfIhqZlWH2vpK21kBBY',
    appId: '1:853473479331:android:7632dd3fbe9c0eda760d16',
    messagingSenderId: '853473479331',
    projectId: 'mobilcihazlar-2a280',
    storageBucket: 'mobilcihazlar-2a280.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhx_KiLAtlzad-kYhnE6EUlePq08Ye1FU',
    appId: '1:853473479331:ios:f43723e8cae12d51760d16',
    messagingSenderId: '853473479331',
    projectId: 'mobilcihazlar-2a280',
    storageBucket: 'mobilcihazlar-2a280.appspot.com',
    iosBundleId: 'com.example.vizeflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhx_KiLAtlzad-kYhnE6EUlePq08Ye1FU',
    appId: '1:853473479331:ios:a6c2f2edf5d7e79f760d16',
    messagingSenderId: '853473479331',
    projectId: 'mobilcihazlar-2a280',
    storageBucket: 'mobilcihazlar-2a280.appspot.com',
    iosBundleId: 'com.example.vizeflutter.RunnerTests',
  );
}
