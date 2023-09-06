import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_01/providers/user_provider.dart';

import 'package:project_01/sccreen/drawer.dart';
import 'package:project_01/sccreen/home_screen.dart';
import 'package:project_01/sccreen/login_screen.dart';
import 'package:project_01/sccreen/registation_screen.dart';
import 'package:project_01/utils/colour.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: homePage()));
  }
}
