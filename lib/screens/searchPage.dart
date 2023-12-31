import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:insta_clone/screens/profilePage.dart';

import '../utils/utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  bool showUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
                labelText: 'Search user',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black.withOpacity(0.3),
                )),
            style: const TextStyle(color: Colors.black),
            onFieldSubmitted: (String _) {
              setState(() {
                showUser = true;
              });
            },
          ),
        ),
        body: showUser
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .where("username",
                        isGreaterThanOrEqualTo: _searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: ListTile(
                            onTap: (){Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=> ProfilePage(
                                    uid: (snapshot.data! as dynamic).docs[index]['uid'])));},
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['imageUrl']),
                            ),
                            title: Text(
                              (snapshot.data! as dynamic).docs[index]['username'],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      });
                },
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection("posts").get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 1.5,
                          childAspectRatio: 1),
                      itemBuilder: (context,index){
                        DocumentSnapshot snap= (snapshot.data! as dynamic).docs[index];
                        return  Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200
                              )),
                          child: Image(
                            image: NetworkImage(
                                snap['postUrl']
                            ),
                            fit: BoxFit.cover,

                          ),
                        );

                      });
                }));
  }
}
