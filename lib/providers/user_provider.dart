import 'package:flutter/widgets.dart';
import '../model/user_inst.dart';
import '../resoures/auth_methods.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Authmethods _authMethods = Authmethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}

// import 'package:flutter/widgets.dart';
// import '../model/user_inst.dart';
// import '../model/user_model.dart';
// import '../resoures/auth_methods.dart'; // Make sure to import the correct path for your Authmethods
// import 'package:flutter/foundation.dart'; // Import ChangeNotifier for ChangeNotifierProvider

// class UserProvider with ChangeNotifier {
//   User? _user;
//   final Authmethods _authMethods = Authmethods();

//   User? get getUser => _user;

//   Future<void> refreshUser() async {
//     UserModel user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }
