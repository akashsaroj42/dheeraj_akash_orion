// import 'dart:js';
// import 'dart:typed_data';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:project_01/sccreen/login_screen.dart';

// import '../utils/util.dart';
// import 'home_screen.dart';
// import '../reso/Stroage_post.dart';

// class newpost extends StatefulWidget {
//   const newpost({super.key});

//   @override
//   State<newpost> createState() => _newpostState();
// }

// class _newpostState extends State<newpost> {
//   Uint8List? _file;
//   final TextEditingController _discription = TextEditingController();
//   final TextEditingController _RentailAmount = TextEditingController();
//   final TextEditingController _Deposite = TextEditingController();
//   final TextEditingController _phone = TextEditingController();
//   final TextEditingController _address = TextEditingController();
//   final TextEditingController _itemName = TextEditingController();

//   void share() async {
//     String discription = _discription.text;
//     String RentailAmount = _RentailAmount.text;
//     String Deposite = _Deposite.text;
//     String phone = _phone.text;
//     String Address = _address.text;
//     String itemname = _itemName.text;

//     String resp = await Storepost().saveDatapost(
//         file: _file!,
//         discription: discription,
//         RentailAmount: RentailAmount,
//         Deposite: Deposite,
//         phone: phone,
//         Address: Address,
//         itemname: itemname);
//   }

//   _selectImage(BuildContext Context) async {
//     return showDialog(
//       context: Context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Create a Post'),
//           children: <Widget>[
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Take a photo'),
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   Uint8List file = await pickImage(ImageSource.camera);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Choose from Gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.gallery);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//               padding: const EdgeInsets.all(20),
//               child: const Text("Cancel"),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         );
//       },
//     );
//   }

//   void clearimage() {
//     setState(() {
//       _file = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _file == null
//         ? Material(
//             color: Colors.grey[900],
//             child: Center(
//               child: Center(
//                 child: IconButton(
//                   onPressed: () {
//                     _selectImage(context);
//                   },
//                   icon: Icon(Icons.upload),
//                   color: Colors.white,
//                   iconSize: 40,
//                 ),
//               ),
//             ),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.grey[900],
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => homePage()),
//                   );
//                 },
//                 icon: const Icon(Icons.arrow_back),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Column(children: [
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 220.0,
//                       width: 350.0,
//                       child: AspectRatio(
//                         aspectRatio: 487 / 451,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   fit: BoxFit.fill,
//                                   alignment: FractionalOffset.topCenter,
//                                   image: MemoryImage(_file!))),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.grey[900],
//                   thickness: 0.50,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextField(
//                           controller: _itemName,
//                           decoration: InputDecoration(
//                               hintText: 'Item name',
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ))),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextField(
//                           controller: _discription,
//                           decoration: InputDecoration(
//                               hintText: 'Description',
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ))),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextField(
//                           controller: _RentailAmount,
//                           decoration: InputDecoration(
//                               hintText: '\$ Rentail Amount',
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ))),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextField(
//                           controller: _Deposite,
//                           decoration: InputDecoration(
//                               hintText: '\$ Deposite',
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ))),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextField(
//                           controller: _phone,
//                           decoration: InputDecoration(
//                               hintText: '\+91 Phone No.',
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ))),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextField(
//                           controller: _address,
//                           decoration: InputDecoration(
//                               hintText: 'Address',
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ))),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                   onPressed: share,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(
//                         vertical: 12.0, horizontal: 35.0), // Adjust padding
//                     minimumSize: Size(15, 20.0),
//                     // Set the button height to 10.0 units
//                   ),
//                   child: Text('Share'),
//                 )
//               ]),
//             ),
//           );
//   }
// }

// import 'dart:js';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_01/sccreen/login_screen.dart';

import '../utils/util.dart';
import 'home_screen.dart';
import '../reso/Stroage_post.dart';

class newpost extends StatefulWidget {
  const newpost({Key? key});

  @override
  State<newpost> createState() => _newpostState();
}

class _newpostState extends State<newpost> {
  Uint8List? _file;
  final TextEditingController _discription = TextEditingController();
  final TextEditingController _RentailAmount = TextEditingController();
  final TextEditingController _Deposite = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _itemName = TextEditingController();

  void share() async {
    String discription = _discription.text;
    String RentailAmount = _RentailAmount.text;
    String Deposite = _Deposite.text;
    String phone = _phone.text;
    String Address = _address.text;
    String itemname = _itemName.text;

    String resp = await Storepost().saveDatapost(
      file: _file!,
      discription: discription,
      RentailAmount: RentailAmount,
      Deposite: Deposite,
      phone: phone,
      Address: Address,
      itemname: itemname,
    );

    // Clear the image after sharing
    clearimage();
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

  void clearimage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 220.0,
                      width: 350.0,
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
                  ],
                ),
                Divider(
                  color: Colors.grey[900],
                  thickness: 0.50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                          controller: _itemName,
                          decoration: InputDecoration(
                              hintText: 'Item name',
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                          controller: _discription,
                          decoration: InputDecoration(
                              hintText: 'Description',
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                          controller: _RentailAmount,
                          decoration: InputDecoration(
                              hintText: '\$ Rentail Amount',
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                          controller: _Deposite,
                          decoration: InputDecoration(
                              hintText: '\$ Deposite',
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                          controller: _phone,
                          decoration: InputDecoration(
                              hintText: '\+91 Phone No.',
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                          controller: _address,
                          decoration: InputDecoration(
                              hintText: 'Address',
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: share,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 35.0), // Adjust padding
                    minimumSize: Size(15, 20.0),
                    // Set the button height to 10.0 units
                  ),
                  child: Text('Share'),
                )
              ]),
            ),
          );
  }
}
