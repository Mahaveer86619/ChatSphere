import 'package:chatsphere/presentation/screens/auth/auth_page.dart';
import 'package:chatsphere/presentation/screens/landing/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatScreen(); // user is logged in
          } else {
            return const AuthScreen(); // user is not logged in
          }
        },
      ),
    );
  }
}