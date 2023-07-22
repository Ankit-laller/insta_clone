import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file!=null){
    return await _file.readAsBytes();
  }
  print("impge not selected");

}

showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}
Widget userPosts(String uid) {
  return FutureBuilder(
    future: FirebaseFirestore.instance.collection("posts")
        .where('uid', isEqualTo: uid).get(),
    builder: (context, snapshot){
      if(snapshot.connectionState ==ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
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
    },
  );
}