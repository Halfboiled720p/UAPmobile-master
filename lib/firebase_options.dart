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
    apiKey: 'AIzaSyAslmT8u2BelDmm7ZgSWeZA06jt1dN0ihc',
    appId: '1:982094958049:web:14231559fb009b642bd6a0',
    messagingSenderId: '982094958049',
    projectId: 'apkmasak-69e27',
    authDomain: 'apkmasak-69e27.firebaseapp.com',
    storageBucket: 'apkmasak-69e27.firebasestorage.app',
    measurementId: 'G-FQWXDXNQ8B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3tsOSWTwRGTCrYPIMXw6ePG_BzS0gq8Q',
    appId: '1:982094958049:android:b36c2105ba3a35602bd6a0',
    messagingSenderId: '982094958049',
    projectId: 'apkmasak-69e27',
    storageBucket: 'apkmasak-69e27.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMXnQ1bvmgxmBqrN2oDPF27j1LsHDHito',
    appId: '1:982094958049:ios:850a5520034aa5c62bd6a0',
    messagingSenderId: '982094958049',
    projectId: 'apkmasak-69e27',
    storageBucket: 'apkmasak-69e27.firebasestorage.app',
    iosBundleId: 'com.example.apkmasak',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMXnQ1bvmgxmBqrN2oDPF27j1LsHDHito',
    appId: '1:982094958049:ios:850a5520034aa5c62bd6a0',
    messagingSenderId: '982094958049',
    projectId: 'apkmasak-69e27',
    storageBucket: 'apkmasak-69e27.firebasestorage.app',
    iosBundleId: 'com.example.apkmasak',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAslmT8u2BelDmm7ZgSWeZA06jt1dN0ihc',
    appId: '1:982094958049:web:4bd6febb7872d90d2bd6a0',
    messagingSenderId: '982094958049',
    projectId: 'apkmasak-69e27',
    authDomain: 'apkmasak-69e27.firebaseapp.com',
    storageBucket: 'apkmasak-69e27.firebasestorage.app',
    measurementId: 'G-QFZQL3L3VV',
  );

}