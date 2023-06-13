import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.

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
    apiKey: 'AIzaSyAubTaW0k2pwrDw1Wib9zJ351pzHINjYmg',
    appId: '1:608261211107:web:a901afd47a6fc2f27956d6',
    messagingSenderId: '608261211107',
    projectId: 'florida-50c8b',
    authDomain: 'florida-50c8b.firebaseapp.com',
    databaseURL: 'https://florida-50c8b-default-rtdb.firebaseio.com',
    storageBucket: 'florida-50c8b.appspot.com',
    measurementId: 'G-Q4BL8RJH4S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRpvXZYGJNB9bxZQXqOATTJ56WEOr1lz8',
    appId: '1:608261211107:android:be4a58e6a73919137956d6',
    messagingSenderId: '608261211107',
    projectId: 'florida-50c8b',
    databaseURL: 'https://florida-50c8b-default-rtdb.firebaseio.com',
    storageBucket: 'florida-50c8b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByprESSy5XDBiHUu0w6ms57hoHW3S71-o',
    appId: '1:608261211107:ios:c3eb1fae38412ce37956d6',
    messagingSenderId: '608261211107',
    projectId: 'florida-50c8b',
    databaseURL: 'https://florida-50c8b-default-rtdb.firebaseio.com',
    storageBucket: 'florida-50c8b.appspot.com',
    androidClientId:
        '608261211107-k7j22p0rjmfdsr5gea3uq7rsmjjcr8v4.apps.googleusercontent.com',
    iosClientId:
        '608261211107-07tph27m0ho8sc0jl5oav5u48hbhaksn.apps.googleusercontent.com',
    iosBundleId: 'com.example.floridaAppStore',
  );
}
