
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/resources/storage_method.dart';
import 'package:insta_clone/utils/utils.dart';
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
  Future<void> likePost(String postId, String uid, List likes)async{
    try{
      if(likes.contains(uid)){
        await _firestore.collection("posts").doc(postId).update({
            'likes' :FieldValue.arrayRemove([uid]),
          });
      }else{
         await _firestore.collection("posts").doc(postId).update({
              'likes' :FieldValue.arrayUnion([uid]),
            });
      }
    }catch(err){
      print(err.toString());
    }
  }
  Future<void> postComment(String postId, String username, String uid, String profImage, String text)async{
    try{
      if(text.isNotEmpty){
        String commentId =const Uuid().v1();
        _firestore.collection("posts").doc(postId).collection("comments").doc(commentId).set({
          "profilePic": profImage,
          "username": username,
          "uid": uid,
          "comment": text,
          "datePublished":DateTime.now(),
          "commentId":commentId

        });
      }else{
        print("text is empty");
      }
    }catch(err) {
      print(err.toString());
    }
  }
}