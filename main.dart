import 'package:chat_app_15/chatscreen.dart';
import 'package:chat_app_15/loginscreen.dart';
import 'package:chat_app_15/registerscreen.dart';
import 'package:chat_app_15/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => welcomescreen(),
        '/loginscreen': (context) => loginscreen(),
        '/Registerscreen': (context) => registerscreen(),
        '/chatscreen': ((context) => chatscreen())
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: welcomescreen(),
    );
  }
}
