import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            SvgPicture.network(
              "https://raw.githubusercontent.com/RivaanRanawat/instagram-flutter-clone/57f92e50238913d1a77b082ea8b061cda74865c9/assets/ic_instagram.svg",
            ),
            Column(children: [
              const SizedBox(
                height: 40,
              ),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter username"),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter email"),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.remove_red_eye),
                    border: OutlineInputBorder(),
                    hintText: "Enter password"),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueAccent),
                  child: const Center(child: Text("Sign Up")),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/Login");
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                  ),
                  InkWell(
                      child: const Text(
                        " Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/Login");
                      }),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}
