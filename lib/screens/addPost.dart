import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/Users.dart';
import '../resources/firestoreMethods.dart';
import '../state_management/user_provider.dart';
import '../utils/colors.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
     Uint8List? _file;
     final TextEditingController _descriptionController = TextEditingController();
      bool _isloading =false;
   _selectImage(BuildContext context) async{
     return showDialog(context: context, builder: (context){
       return SimpleDialog(
         title: Text("Create a Post"),
         children: [
           SimpleDialogOption(
             padding: const EdgeInsets.all(20),
             child: const Text('Take a photo'),
             onPressed: ()async{
               Navigator.of(context).pop();
               Uint8List file = await pickImage(ImageSource.camera);
               setState(() {
                 _file = file;
               });
             },
           ),
           SimpleDialogOption(
             padding: const EdgeInsets.all(20),
             child: const Text('choose from gallery'),
             onPressed: ()async{
               Navigator.of(context).pop();
               Uint8List file = await pickImage(ImageSource.gallery);
               setState(() {
                 _file = file;
               });
             },
           ),
           SimpleDialogOption(
             padding: const EdgeInsets.all(20),
             child: const Text('Cancel '),
             onPressed: ()async{
               Navigator.of(context).pop();
             },
           ),
         ],
       );
     });
   }
   void clearimage(){
     _file =null;
   }
   @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
  void postImage(
      String uid,
      String username,
      String profileImg
      )async{
     setState(() {
       _isloading =true;
     });
     try{
       String res = await FireStoreMethod().uploadPost(_descriptionController.text, _file!,
           uid, username, profileImg);
       if(res=="success"){
         setState(() {
           _isloading =false;
         });
         showSnackBar("image posted", context);
         clearimage();
       }else{
         showSnackBar(res, context);
       }
     }catch(err){
        showSnackBar(err.toString(), context);
     }
  }

  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<UserProvier>(context).getUser;
    return _file == null
        ? Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
        ),
        onPressed: () => _selectImage(context),
      ),
    ): Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){},
        ),
        title: const Text(
          'Post to',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(onPressed: (){
            postImage(user.uid, user.username, user.imageUrl);
          },
        child:Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _isloading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.imageUrl
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                          image: MemoryImage(
                              _file!
                          ),
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
