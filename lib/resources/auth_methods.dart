import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/Users.dart';
import 'package:insta_clone/resources/storage_method.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Users> getUserDetails() async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection("users").doc(currentUser.uid).get();
    return Users.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
      file !=null
      ) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String imageUrl = await storageMethod().uploadImages("Profile Pics", file, false);
        Users user = Users(email: email,
            uid: cred.user!.uid,
            imageUrl: imageUrl,
            username: username,
            bio: bio,
            followers: [],
            following: []
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson(),);
        res = "success";
      }
    } catch (err) {
      return err.toString();
    }

    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
