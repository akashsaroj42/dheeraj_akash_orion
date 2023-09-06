import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String rentalamount;
  final String deposite;
  // final String uid;
  // final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  // final String postUrl;
  // final String profImage;

  const Post({
    required this.description,
    required this.rentalamount,
    required this.deposite,
    // required this.uid,
    // required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    // required this.postUrl,
    // required this.profImage,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      deposite: snapshot["deposite"],
      rentalamount: snapshot["rentalamount"],
      // uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      // username: snapshot["username"],
      // postUrl: snapshot['postUrl'],
      // profImage: snapshot['profImage']
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "deposite": deposite,
        "rentalamount": rentalamount,
        // "uid": uid,
        "likes": likes,
        // "username": username,
        "postId": postId,
        "datePublished": datePublished,
        // 'postUrl': postUrl,
        // 'profImage': profImage
      };
}
