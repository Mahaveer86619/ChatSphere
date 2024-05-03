import 'package:chatsphere/config/model/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference? usersCollection;

  DatabaseService() {
    setUpCollectionReference();
  }

  void setUpCollectionReference() {
    usersCollection =
        firebaseFirestore.collection("users").withConverter<UserProfile>(
              fromFirestore: (snapshots, _) => UserProfile.fromJson(
                snapshots.data()!,
              ),
              toFirestore: (userProfile, _) => userProfile.toJson(),
            );
  }

  Future<bool> checkIfUserExists(String uid) async {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final docSnapshot = await userDocRef.get();
    return docSnapshot.exists;
  }

  Future<bool> createUserProfile(UserProfile userProfile) async {
    bool result = true;
    await usersCollection
        ?.doc(userProfile.uid) // id
        .set(userProfile) // data
        .onError((error, _) {
      debugPrint('Error uploading user profile: $error');
      result = false;
    }); // id and // data
    return result;
  }

  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final docSnapshot = await userDocRef.get();

    // Check if document exists
    if (docSnapshot.exists) {
      return docSnapshot.data();
    } else {
      return null;
    }
  }
}
