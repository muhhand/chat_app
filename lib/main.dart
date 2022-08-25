import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Screens/chat_Page.dart';
import 'package:scholar_chat/Screens/login_Screen.dart';
import 'package:scholar_chat/Screens/register_Screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage' : (context) => LoginPage(),
        'RegisterPage' : (context) => RegisterScreen(),
        ChatPage.id : (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      initialRoute: "LoginPage",
    );
  }
}

