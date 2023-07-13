import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/utils/utils.dart';

import '../Widget/text_field_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
   bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

void selectImage()async{
   Uint8List im= await pickImage(ImageSource.gallery);
   setState(() {
     _image = im;
   });
}
void signUp() async{
    setState(() {
      _isLoading = true;
    });
  String res= await AuthMethods().signUpUser(email: _emailController.text, password: _passwordController.text,
      username: _usernameController.text, bio: _bioController.text,
      file: _image!);

  setState(() {
    _isLoading = false;
  });
  if(res!= "success"){
      showSnackBar(res, context);
  }else{
    Navigator.pushNamed(context, "/Login");
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
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                    backgroundColor: Colors.red,
                  )
                      : const CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage(
                        'asset/user.png'),
                    backgroundColor: Colors.red,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: (){
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              Column(children: [
                const SizedBox(
                  height: 40,
                ),
                TextFieldInput(
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                ),

                const SizedBox(height: 20),
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
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                  textEditingController: _bioController,
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
                child: _isLoading? const Center(child: CircularProgressIndicator(color: Colors.white,),) : const Center(child: Text("Sign Up")),
                  ),
                  onTap: () {
                    signUp();

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
      ),
    );
  }
}
