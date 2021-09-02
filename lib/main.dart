// ignore_for_file: use_key_in_widget_constructors

import 'package:chat/loginPage/sign_up.dart';
import 'package:chat/ui/chatui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      // initialRoute: _authUser.currentUser != null ? '/chatui' : '/singinup',
      initialRoute: '/singinup',
      routes: {
        '/singinup': (context) => const SingInUp(),
        '/chatui': (context) => ChatUi(),
      },

    );
  }
}
