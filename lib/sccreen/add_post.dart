import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_01/model/post.dart';
import 'package:project_01/model/user_inst.dart';
import 'package:project_01/model/user_model.dart';
import 'package:project_01/resoures/firestore.dart';
import 'package:project_01/sccreen/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/util.dart';

class addposts extends StatefulWidget {
  const addposts({super.key});

  @override
  State<addposts> createState() => _addpostsState();
}

class _addpostsState extends State<addposts> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _RentalAmount = TextEditingController();
  final TextEditingController _Deposite = TextEditingController();

  void postImage(
      // String uid,
      // String username,
      // String profImage,
      // String postUrl,
      ) async {
    try {
      String res = await Firestoremethods().uplodePost(
          _descriptionController.text,
          _RentalAmount.text,
          _Deposite.text,
          _file!);
      // _Deposite.text,
      // _RentalAmount.text,
      // _Deposite.text,
      // _file!
      // username,
      // uid,
      // profImage,
      // postUrl
      // );

      if (res == " success") {
        showSnackBar('Posted!' as BuildContext, context as String);
      } else {
        showSnackBar(res as BuildContext, context as String);
      }
    } catch (e) {
      showSnackBar(e.toString() as BuildContext, context as String);
    }
  }

  _selectImage(BuildContext Context) async {
    return showDialog(
      context: Context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _RentalAmount.dispose();
    _Deposite.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Material(
            color: Colors.grey[900],
            child: Center(
              child: Center(
                child: IconButton(
                  onPressed: () {
                    _selectImage(context);
                  },
                  icon: Icon(Icons.upload),
                  color: Colors.white,
                  iconSize: 40,
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[900],
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homePage()),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text("Post to"),
              actions: [
                TextButton(
                  onPressed: () => postImage(),
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150.0,
                      width: 80.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter,
                                  image: MemoryImage(_file!))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                        maxLines: 7,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[900],
                  thickness: 0.50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                        controller: _RentalAmount,
                        decoration: InputDecoration(
                            hintText: 'Rentail Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _Deposite,
                        decoration: InputDecoration(
                            hintText: 'Deposite',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                  ],
                ),
                Divider(
                  color: Colors.grey[900],
                  thickness: 0.50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.location_pin)),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'location',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[900],
                  thickness: 0.50,
                ),
              ],
            ),
          );
  }
}
