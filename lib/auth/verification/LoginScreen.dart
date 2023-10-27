import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yoo_katale/auth/verification/OTP.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // paste the code copied
      // from Firebase SDK below.
      options: const FirebaseOptions(
          apiKey: "",
          authDomain: "",
          projectId: "",
          storageBucket: "",
          messagingSenderId: "",
          appId: "",
          measurementId: ""));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the
// root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhoneOTPVerification(),
    );
  }
}
