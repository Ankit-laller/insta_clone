import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/resources/firestoreMethods.dart';
import 'package:insta_clone/state_management/user_provider.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/Users.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (err) {
      showSnackBar(
        err.toString(),
        context
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return isLoading ?Center(child: const CircularProgressIndicator()):Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
            userData['username'] ?? "username",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions:  [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed:  () {FirebaseAuth.instance.signOut();},
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(userData['imageUrl'])),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             Column(
                              children: [
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    postLen.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                const Text("posts"),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //         const FollowPage()));
                                  },
                                  child:  Text(
                                    followers.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                const Text(
                                  "followers",
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //         const FollowPage()));
                                    },
                                    child:  Text(following.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))),
                                const Text("following"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(userData['username']),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(userData['bio']),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                FirebaseAuth.instance.currentUser?.uid ==widget.uid ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 35,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TextButton(

                            onPressed: () {},
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.black),
                            ))),
                    Container(
                        height: 35,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TextButton(
                            child: const Text(
                              "Share Profile",
                              style: TextStyle(color: Colors.black),
                            ),
                          onPressed: () {

                          },),),
                  ],
                ): isFollowing? Container(
                    height: 35,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),

                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue, // Background Color
                        ),
                        onPressed: () async{
                          await FireStoreMethod().followUser(FirebaseAuth.instance.currentUser!.uid,
                              userData['uid']);
                          setState(() {
                            isFollowing = false;
                            followers--;
                          });
                        },
                        child: const Text(
                          "Unfollow",
                          style: TextStyle(color: Colors.black),
                        ))) :Container(
                    height: 35,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextButton(
                        onPressed: () async{
                          await FireStoreMethod().followUser(FirebaseAuth.instance.currentUser!.uid,
                              userData['uid']);
                          setState(() {
                            isFollowing = true;
                            followers++;
                          });
                        },
                        child: const Text(
                          "Follow",
                          style: TextStyle(color: Colors.black),
                        ))) ,
                const SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 12.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       story('asset/image.jpg', "movie"),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       story('asset/image.jpg', "fun"),
                //     ],
                //   ),
                // ),
              ],
            ),
            const Divider(
              height: 10,
            ),
            DefaultTabController(
              length: 2,
              child: TabBar(
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.grid_on_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  Tab(
                      icon: Icon(
                    Icons.perm_contact_cal_outlined,
                    color: Colors.grey,
                  ))
                ],
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [userPosts(widget.uid), const Text('Person')],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
