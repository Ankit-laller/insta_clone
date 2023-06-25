import 'package:flutter/material.dart';
import 'package:insta_clone/screens/HomePage.dart';
import 'package:insta_clone/screens/actionPage.dart';
import 'package:insta_clone/screens/loginPage.dart';
import 'package:insta_clone/screens/profilePage.dart';
import 'package:insta_clone/screens/searchPage.dart';
import 'package:insta_clone/screens/signUpPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/Login",
        routes: {
          "/Login": (BuildContext context) => const LoginPage(),
          "/home" : (BuildContext context)=> const HomePage(),
          "/search": (BuildContext context) => const SearchPage(),
          "/actions": (BuildContext context) => const ActionPage(),
          "/profile": (BuildContext context) => const ProfilePage(),
          "/SignUp": (BuildContext context)=> const SignUpPage(),
        });

  }
}
