import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'avatarimage.dart'; // Assuming you have this file
import 'login_screen.dart'; // Assuming you have this file
import '../reso/add_data.dart'; // Assuming you have this file
import '../model/user_model.dart'; // Assuming you have this file

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickimagge(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(); // Initialize with an empty UserModel

  @override
  void initState() {
    super.initState();
    if (user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          loggedInUser = UserModel.fromMap(value.data()!);
          setState(() {});
        }
      });
    }
  }

  void saveProfile() async {
    String resp = await StoreData().saveData(file: _image!);
    print(resp); // Print response for debugging
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[900],
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            child: Stack(
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: MemoryImage(_image!),
                                        backgroundColor: Colors.red,
                                      )
                                    : const CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            'https://i.stack.imgur.com/l60Hf.png'),
                                        backgroundColor: Colors.red,
                                      ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('userProfile')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }

                                    final userProfiles =
                                        snapshot.data!.docs.reversed.toList();

                                    if (userProfiles.isEmpty) {
                                      return const SizedBox(); // No data, return an empty widget
                                    }

                                    final imageUrl =
                                        userProfiles.first['imagelink'];

                                    return CircleAvatar(
                                      backgroundImage: NetworkImage(imageUrl),
                                      radius: 50,
                                      backgroundColor: Colors.red,
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: 60,
                                  child: IconButton(
                                    onPressed: selectImage,
                                    icon: const Icon(Icons.add_a_photo),
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: saveProfile,
                            child: Text('Save Profile'),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                          ),
                          accountName: Center(
                            child: Text(
                              "${loggedInUser.firstName ?? ''} ${loggedInUser.secondName ?? ''}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ),
                          accountEmail: Center(
                            child: Text(
                              "${loggedInUser.email ?? ''}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.list_bullet,
                  color: Colors.white,
                ),
                title: Text(
                  "My List",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Implement your action here
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.shopping_cart,
                  color: Colors.white,
                ),
                title: Text(
                  "Shop",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Implement your action here
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.macwindow,
                  color: Colors.white,
                ),
                title: Text(
                  "Notification",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Implement your action here
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.arrow_turn_right_down,
                  color: Colors.white,
                ),
                title: Text(
                  "Logout",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
