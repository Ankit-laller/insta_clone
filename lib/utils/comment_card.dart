import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            widget.snap["profilePic"]
          ),
          radius: 18,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style:  TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: widget.snap['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                      text: '   ${widget.snap['comment']}',

                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "17/7/2023",
                  style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),
                ),
              )
            ],
          ),
        ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.favorite,
            size: 16,
          ),
        )
      ],
    ));
  }
}
