import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/responsive/mobileScreenLayout.dart';
import 'package:insta_clone/responsive/responsive_layout.dart';
import 'package:insta_clone/responsive/webScreenLayout.dart';
import 'package:insta_clone/screens/HomePage.dart';
import 'package:insta_clone/screens/actionPage.dart';
import 'package:insta_clone/screens/loginPage.dart';
import 'package:insta_clone/screens/profilePage.dart';
import 'package:insta_clone/screens/searchPage.dart';
import 'package:insta_clone/screens/signUpPage.dart';
import 'package:insta_clone/state_management/user_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCo-CeFoR60zgGxwABwhZpsVlL2polpEeQ",
          appId: "1:530479599144:android:7bbfdbb125f0cbfb4baf1d",
          messagingSenderId: "530479599144",
          projectId: "insta-clone-2d443",
          storageBucket: 'insta-clone-2d443.appspot.com'
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserProvier())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
                  return ResponsiveLayout(webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LoginPage();
            }
          ),
          // initialRoute: "/Login",
          routes: {
            "/Login": (BuildContext context) => const LoginPage(),
            "/home" : (BuildContext context)=> const HomePage(),
            "/search": (BuildContext context) => const SearchPage(),
            "/actions": (BuildContext context) => const ActionPage(),
            "/profile": (BuildContext context) => const ProfilePage(),
            "/SignUp": (BuildContext context)=> const SignUpPage(),
          }),
    );

  }
}
