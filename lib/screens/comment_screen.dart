import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/resources/firestoreMethods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/comment_card.dart';
import 'package:provider/provider.dart';

import '../models/Users.dart';
import '../state_management/user_provider.dart';

class CommentScreen extends StatefulWidget {
  final postId;
  const CommentScreen({super.key,required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<UserProvier>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection("posts").doc(widget.postId).collection('comments')
            .orderBy("datePublished", descending: true).snapshots(),
        builder: (context, snapshot){
          if(snapshot.connectionState ==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context,index)=>CommentCard(
                snap:(snapshot.data! as dynamic).docs[index].data()
              ));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.imageUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    // controller: commentEditingController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                    controller: _commentController,
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  await FireStoreMethod().postComment(widget.postId,
                      user.username, user.uid, user.imageUrl, _commentController.text);
                  setState(() {
                    _commentController.clear();
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
