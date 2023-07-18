import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/screens/HomePage.dart';
import 'package:insta_clone/screens/actionPage.dart';
import 'package:insta_clone/screens/addPost.dart';
import 'package:insta_clone/screens/profilePage.dart';
import 'package:insta_clone/screens/searchPage.dart';

import '../utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page =0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationtap(int page){
    pageController.jumpToPage(page);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.camera_alt,
      //       size: 20,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {},
      //   ),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   title: const Text(
      //     "Instagram",
      //     style:
      //     TextStyle(fontFamily: "Genel", fontSize: 30, color: Colors.black),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(
      //         Icons.live_tv,
      //         size: 20,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {
      //         AuthMethods().signOut();
      //         Navigator.pushNamed(context, "/Login");
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(
      //         Icons.send,
      //         size: 20,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {
      //         // Navigator.of(context).push(
      //         //     MaterialPageRoute(builder: (context) => const ChatPage()));
      //       },
      //     ),
      //   ],
      // ),
      // body: const Center(
      //   child: Text("Home"),
      // ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
            HomePage(),
          SearchPage(),
          AddPostPage(),
          ActionPage(),
          ProfilePage()

        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: (_page == 3) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 4) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationtap,
        currentIndex: _page,
      ),
    );
  }
}
