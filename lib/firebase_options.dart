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
    apiKey: 'AIzaSyC3kxXqy9zXf2sCGRthAzMS9D4fStE6Hqk',
    appId: '1:405967633761:web:d038079913f7d61ad0d920',
    messagingSenderId: '405967633761',
    projectId: 'carpooling-abade',
    authDomain: 'carpooling-abade.firebaseapp.com',
    storageBucket: 'carpooling-abade.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARVZ4NzzHtweRiJkW92xifZlc4CyMQ3wc',
    appId: '1:405967633761:android:6a867701872aeb00d0d920',
    messagingSenderId: '405967633761',
    projectId: 'carpooling-abade',
    storageBucket: 'carpooling-abade.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbO9b0MyjpoYWhVm6Y1kjGIZLL264M2vg',
    appId: '1:405967633761:ios:410db3dff9c33456d0d920',
    messagingSenderId: '405967633761',
    projectId: 'carpooling-abade',
    storageBucket: 'carpooling-abade.appspot.com',
    iosBundleId: 'com.example.projectPart1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbO9b0MyjpoYWhVm6Y1kjGIZLL264M2vg',
    appId: '1:405967633761:ios:a6b476fca2038b58d0d920',
    messagingSenderId: '405967633761',
    projectId: 'carpooling-abade',
    storageBucket: 'carpooling-abade.appspot.com',
    iosBundleId: 'com.example.projectPart1.RunnerTests',
  );
}
