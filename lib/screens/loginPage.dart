import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/utils/utils.dart';

import '../Widget/text_field_input.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login()async{
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isloading = false;
    });
    if(res=="success"){
      Navigator.pushNamed(context, "/home");

    }else{
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              SvgPicture.asset("asset/instagram-text-icon.svg",
                height: 64,
              ),
              Column(children: [
                const SizedBox(
                  height: 40,
                ),
                TextFieldInput(
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
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
                    child: _isloading ?const Center(child: CircularProgressIndicator(color: Colors.white,),): const Center(child: Text("Login")),
                  ),
                    onTap: () {
                      login();
                    }
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                    ),
                    InkWell(
                        child: const Text(
                          " Sign up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/SignUp");
                        }),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
