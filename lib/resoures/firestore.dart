import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_01/model/post.dart';
import 'package:project_01/resoures/storage_methods.dart';
import 'package:uuid/uuid.dart';

class Firestoremethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uplodePost(
    String description,
    String rentalamount,
    String deposite,
    Uint8List file,
    // String username,
    // String uid,
    // String postUrl,
    // String profImage
  ) async {
    String res = " some error occurred ";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('post', file, true);

      String postid = const Uuid().v1();

      Post post = Post(
        description: description,
        rentalamount: rentalamount,
        deposite: deposite,
        // uid: uid,
        // username: username,
        likes: [],
        postId: postid,
        datePublished: DateTime.now(),
        // postUrl: postUrl,
        // profImage: profImage
      );

      _firestore.collection('posts').doc(postid).set(
            post.toJson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
