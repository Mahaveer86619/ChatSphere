import 'package:chatsphere/firebase_options.dart';
import 'package:chatsphere/config/themes/theme.dart';
import 'package:chatsphere/presentation/helpers/auth_gate.dart';
import 'package:chatsphere/presentation/screens/auth/auth_page.dart';
import 'package:chatsphere/presentation/screens/auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatSphere',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const SafeArea(
        child: AuthGate(),
      ),
    );
  }
}
