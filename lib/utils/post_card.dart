import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/Users.dart';
import 'package:insta_clone/resources/firestoreMethods.dart';
import 'package:insta_clone/screens/comment_screen.dart';
import 'package:insta_clone/state_management/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}):
        super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isAnimating = false;
  @override

  Widget build(BuildContext context) {
    final Users user = Provider.of<UserProvier>(context).getUser;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading:  CircleAvatar(
              backgroundImage: NetworkImage(widget.snap['profImage']),
            ),
            title: Text(
              widget.snap['username'],
              style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 21),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          GestureDetector(
            onDoubleTap: ()async{
               await FireStoreMethod().likePost(widget.snap['postId'],
                   user.uid, widget.snap['likes']);
              setState(() {
                isAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height *0.35,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,

                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isAnimating ?1:0,
                  child: LikeAnimation(child: const Icon(Icons.favorite,
                    size: 80,
                    color: Colors.red,),
                      isAnimating: isAnimating,
                      duration: Duration(milliseconds: 400),
                    onEnd: (){
                    setState(() {
                      isAnimating = false;
                    });
                    },
                  ),
                )
              ],
            ),
          ),
           Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user.uid),
                      smallLike: true,
                      child: IconButton(
                        onPressed: ()async {
                          await FireStoreMethod().likePost(widget.snap['postId'],
                              user.uid, widget.snap['likes']);
                        },
                        icon: widget.snap['likes'].contains(user.uid) ?
                        const Icon(Icons.favorite, color: Colors.red,):const Icon(Icons.favorite_border,
                        ),
                        iconSize: 31,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context)=>CommentScreen(postId: widget.snap['postId'].toString(),))
                        );
                      },
                      icon:const Icon(Icons.comment_sharp),
                      iconSize: 31,
                    ),

                    IconButton(
                      onPressed: () {},
                      icon:const Icon(Icons.send),
                      iconSize: 31,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon:const Icon(Icons.bookmark_border),
                  iconSize: 31,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              '${widget.snap['likes'].length} likes',
              style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8), fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical:2.0),
            margin: const EdgeInsets.only(left: 12),
            child: RichText(
              text: TextSpan(
                style:  TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: widget.snap['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextSpan(
                    text: "  ${widget.snap['description']}",
                  ),
                ]
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              margin: const EdgeInsets.only(left: 12),
              child: Text(
                "View all 200 comments",
                style: TextStyle(fontSize: 15,color: CupertinoColors.black),
              ),
            ),
            onTap: (){

            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            margin: const EdgeInsets.only(left: 12),
            child: Text(
              DateFormat.yMMMd().format(
                  widget.snap['datePublished'].toDate())
              ,
              style: TextStyle(fontSize: 15,color: CupertinoColors.black),
            ),
          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}
