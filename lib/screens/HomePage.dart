import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/utils/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.camera_alt,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Instagram",
          style:
          TextStyle(fontFamily: "Genel", fontSize: 30, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.live_tv,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              AuthMethods().signOut();
              Navigator.pushNamed(context, "/Login");
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => const ChatPage()));
            },
          ),
        ],
      ),
      // body: ListView(
      //   children: <Widget>[
      //     SizedBox(height: 10,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text(
          //         'Stories',
          //         style: TextStyle(
          //             color: Colors.black.withOpacity(.8),
          //             fontWeight: FontWeight.w600,
          //             fontSize: 19),
          //       ),
          //       Row(
          //         children: <Widget>[
          //           const Icon(
          //             Icons.arrow_right,
          //             size: 43,
          //           ),
          //           Text(
          //             'Watch All',
          //             style: TextStyle(
          //                 color: Colors.black.withOpacity(.8),
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 19),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: const EdgeInsets.only(left: 15),
          //   height: 122,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.only(right: 12),
          //         child: Column(
          //           children: <Widget>[
          //             Stack(
          //               children: <Widget>[
          //                 // Container(
          //                 //   width: 75,
          //                 //   height: 75,
          //                 //   decoration: const BoxDecoration(
          //                 //       shape: BoxShape.circle,
          //                 //       image: DecorationImage(
          //                 //           image:
          //                 //           AssetImage('asset/image.jpg'),
          //                 //           fit: BoxFit.cover)),
          //                 // ),
          //                 // Positioned(
          //                 //   bottom: 0,
          //                 //   right: -1,
          //                 //   child: Container(
          //                 //     decoration: BoxDecoration(
          //                 //         color: Colors.blue,
          //                 //         shape: BoxShape.circle,
          //                 //         border: Border.all(color: Colors.white)),
          //                 //     child: const Icon(Icons.add, color: Colors.white),
          //                 //   ),
          //                 // )
          //               ],
          //             ),
          //             // const SizedBox(
          //             //   height: 5,
          //             // ),
          //             // Text(
          //             //   'My Story',
          //             //   style: TextStyle(
          //             //       color: Colors.black.withOpacity(.8),
          //             //       fontWeight: FontWeight.w500),
          //             // )
          //           ],
          //         ),
          //       ),
          //       // story(
          //       //   'asset/image.jpg',
          //       //   'Nergis Bırasoglu',
          //       // ),
          //       // story(
          //       //   'asset/image.jpg',
          //       //   'Barbara Palvin',
          //       // ),
          //       // story('asset/image.jpg', 'Emir'),
          //       // story('asset/image.jpg', 'Abdullah'),
          //       // story('asset/image.jpg', 'Mert'),
          //     ],
          //   ),
          // ),
    //       PostCard(),
    //       PostCard(),
    //       PostCard(),
    //       PostCard(),
    //     ],
    //   ),
    //
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts")
            .orderBy("datePublished", descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) => PostCard(
                snap: snapshot.data?.docs[index].data(),
              )
              );
        },
      ),
    );
  }
}

// Widget story(String image, name) {
//   return Padding(
//     padding: const EdgeInsets.only(right: 12),
//     child: Column(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(0.1),
//           width: 76,
//           height: 76,
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: const Color(0xFFc05ba6), width: 3)),
//           child: ClipOval(
//             child: Image.asset(
//               image,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           name,
//           style: TextStyle(
//               color: Colors.black.withOpacity(.8), fontWeight: FontWeight.w500),
//         )
//       ],
//     ),
//   );
// }



