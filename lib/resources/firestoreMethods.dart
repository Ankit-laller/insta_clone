
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String postId = const Uuid().v1();
  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profileImage
      )async{
    String res ="Some error";
    try{
      String imageUrl = await storageMethod().uploadImages("posts", file, true);
      Post post = Post(
        description: description,
        profImage: profileImage,
        uid: uid,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: imageUrl,
        username: username,
        likes: []
      );
      _firestore.collection("posts").doc(postId).set(post.toJson());
      res="success";
    }catch(err){
      res = err.toString();
    }
    return res;
  }
}