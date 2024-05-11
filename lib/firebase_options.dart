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
    apiKey: 'AIzaSyAM8f7UfWGwEAphnMgvwHq4Dpx3oLS0k3g',
    appId: '1:637511448346:web:3faeb7b9214f25af4c9ea3',
    messagingSenderId: '637511448346',
    projectId: 'e-commerce-school-project',
    authDomain: 'e-commerce-school-project.firebaseapp.com',
    storageBucket: 'e-commerce-school-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6Y8NNmlVzd91t8oL-ivbt6euQYt-pi7A',
    appId: '1:637511448346:android:74da6a74119747ea4c9ea3',
    messagingSenderId: '637511448346',
    projectId: 'e-commerce-school-project',
    storageBucket: 'e-commerce-school-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL6tBUl9V3QZtGD5BUoyW33fpen5lN_ts',
    appId: '1:637511448346:ios:9628ae3efd609e4d4c9ea3',
    messagingSenderId: '637511448346',
    projectId: 'e-commerce-school-project',
    storageBucket: 'e-commerce-school-project.appspot.com',
    iosClientId: '637511448346-h99ki1m24rg715feoapviuk224dds9gc.apps.googleusercontent.com',
    iosBundleId: 'com.example.eCommereceSchoolProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAL6tBUl9V3QZtGD5BUoyW33fpen5lN_ts',
    appId: '1:637511448346:ios:9628ae3efd609e4d4c9ea3',
    messagingSenderId: '637511448346',
    projectId: 'e-commerce-school-project',
    storageBucket: 'e-commerce-school-project.appspot.com',
    iosClientId: '637511448346-h99ki1m24rg715feoapviuk224dds9gc.apps.googleusercontent.com',
    iosBundleId: 'com.example.eCommereceSchoolProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAM8f7UfWGwEAphnMgvwHq4Dpx3oLS0k3g',
    appId: '1:637511448346:web:01e43649919925a84c9ea3',
    messagingSenderId: '637511448346',
    projectId: 'e-commerce-school-project',
    authDomain: 'e-commerce-school-project.firebaseapp.com',
    storageBucket: 'e-commerce-school-project.appspot.com',
  );

}