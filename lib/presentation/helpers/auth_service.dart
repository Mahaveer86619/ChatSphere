import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthService() {}

  User? user;

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<bool> emailSignIn(String email, String password) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        user = credentials.user;
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> emailSignUp(String email, String password) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        user = credentials.user;
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> otpSignIn(String otp, String verificationId) async {
    try {
      final auth = FirebaseAuth.instance;
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final credentials = await auth.signInWithCredential(credential);
      if (credentials.user != null) {
        user = credentials.user;
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> googleAuth() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      final credentials = await auth.signInWithProvider(googleAuthProvider);
      if (credentials.user != null) {
        user = credentials.user;
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
