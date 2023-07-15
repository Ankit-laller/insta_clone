
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users{
  final String email;
  final String uid;
  final String imageUrl;
  final String username;
  final String bio;
  List  followers;
  List following;

  Users({
    required this.email,
    required this.uid,
    required this.imageUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,

});

  Map<String, dynamic> toJson() =>{
  'username': username,
  'uid':uid,
  'email':email,
  'bio':bio,
  'followers':followers,
  'following':following,
  'imageUrl':imageUrl
  };

  static Users fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Users(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot["email"],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
        imageUrl: snapshot['imageUrl']
    );
  }

}