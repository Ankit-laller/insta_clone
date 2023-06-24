import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_clone/screens/loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            SvgPicture.network(
              "https://raw.githubusercontent.com/RivaanRanawat/instagram-flutter-clone/57f92e50238913d1a77b082ea8b061cda74865c9/assets/ic_instagram.svg",
            ),
            Container(
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter username"),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter email"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(),
                      hintText: "Enter password"),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueAccent),
                    child: Center(child: Text("Sign Up")),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                      ),
                      InkWell(
                          child: Text(
                            " Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
