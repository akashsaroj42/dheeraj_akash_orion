import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  // final String? photoUrl;
  // final String? username;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    // this.photoUrl,
    // this.username
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      // photoUrl: map['photoUrl'],
      // username: map['usernme']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      // 'photoUrl': photoUrl,
      // 'username': username,
    };
  }

  // static UserModel fromSnap(DocumentSnapshot<Object?> documentSnapshot) {
  //   var snap;
  //   var snapshot = snap.data() as Map<String, dynamic>;

  //   return UserModel(
  //     uid: snapshot['uid'],
  //     email: snapshot['email'],
  //     firstName: snapshot['firstName'],
  //     secondName: snapshot['secondName'],
  //   );
  // }
}
