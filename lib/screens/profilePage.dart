import 'package:flutter/material.dart';
import 'package:insta_clone/screens/HomePage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "user_name",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.black,
                ),
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('asset/image.jpg')),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(
                              children: [
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text("posts"),
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
                                  child: const Text(
                                    "237",
                                    style: TextStyle(
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
                                    child: const Text("270",
                                        style: TextStyle(
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
               const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text("User Name"),
                    ),
                  ],
                ),
                const Row(
                  children:  [
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text("Flutter Developer"),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 35,
                        width: 200,
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
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Share Profile",
                              style: TextStyle(color: Colors.black),
                            ))),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      story('asset/image.jpg', "movie"),
                      const SizedBox(
                        width: 10,
                      ),
                      story('asset/image.jpg', "fun"),
                    ],
                  ),
                ),

              ],
            ),
            const Divider(
              height: 10,
            ),
            DefaultTabController(
              length: 2,
              child:  TabBar(tabs: const [
                  Tab(icon: Icon(Icons.grid_on_rounded, color: Colors.grey,),),
                  Tab(icon: Icon(Icons.perm_contact_cal_outlined,color: Colors.grey,))
                ],
                controller: _tabController,
              ),
              ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  [
                  userPosts(), const Text('Person')],
              ),
            ),



          ],
        ),


      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            icon:
            const Icon(Icons.home_outlined, size: 32, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(Icons.search, size: 32, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/actions");
            },
            icon: const Icon(Icons.favorite_border,
                size: 32, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
            icon:
            const Icon(Icons.person, size: 32, color: Colors.black),
          ),
        ],
      ),
    );
  }
  Widget  userPosts(){
    return const Column(
      children: [

        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 120,
                  height: 150,
                  child:  Image(
                    image: AssetImage("asset/image.jpg"),
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                  width: 120,
                  height: 150,
                  child: Image(
                    image: AssetImage("asset/image.jpg"),
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                  width: 120,
                  height: 150,
                  child: Image(
                    image: AssetImage("asset/image.jpg"),
                    fit: BoxFit.contain,
                  ))
            ],
          ),
        )
      ],
    );
  }
}