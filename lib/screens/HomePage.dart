import 'package:flutter/material.dart';
import 'package:insta_clone/resources/auth_methods.dart';

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
              Icons.send,
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Stories',
                  style: TextStyle(
                      color: Colors.black.withOpacity(.8),
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.arrow_right,
                      size: 43,
                    ),
                    Text(
                      'Watch All',
                      style: TextStyle(
                          color: Colors.black.withOpacity(.8),
                          fontWeight: FontWeight.w600,
                          fontSize: 19),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            height: 122,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            width: 75,
                            height: 75,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                    AssetImage('asset/image.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'My Story',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                story(
                  'asset/image.jpg',
                  'Nergis Bırasoglu',
                ),
                story(
                  'asset/image.jpg',
                  'Barbara Palvin',
                ),
                story('asset/image.jpg', 'Emir'),
                story('asset/image.jpg', 'Abdullah'),
                story('asset/image.jpg', 'Mert'),
              ],
            ),
          ),
          post('asset/image.jpg', "talha.bayrakci"),
          post('asset/image.jpg', "Nergis Bırasoglu"),
          post('asset/image.jpg', "barbara_palvin"),
          post('asset/image.jpg', "emirorkcu"),
        ],
      ),

    );
  }
}

Widget story(String image, name) {
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0.1),
          width: 76,
          height: 76,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFc05ba6), width: 3)),
          child: ClipOval(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.black.withOpacity(.8), fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}

Widget post(String image, name) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('asset/image.jpg'),
          ),
          title: Text(
            name,
            style: TextStyle(
                color: Colors.black.withOpacity(.8),
                fontWeight: FontWeight.w400,
                fontSize: 21),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        Image.asset(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.favorite_border, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.comment_sharp, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.send, size: 31),
                ],
              ),
              Icon(Icons.bookmark_border, size: 31)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            'liked by you and 385 others',
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
          ),
        )
      ],
    ),
  );
  }

