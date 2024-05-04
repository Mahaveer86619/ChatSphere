import 'package:chatsphere/config/model/friend_requests.dart';
import 'package:chatsphere/config/model/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'auth_service.dart';

class DatabaseService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference? usersCollection, friendRequestCollection;

  final GetIt getIt = GetIt.instance;
  late AuthService authService;

  DatabaseService() {
    setUpUsersCollectionReference();
    setUpFriendRequestCollectionReference();

    authService = getIt.get<AuthService>();
  }

  void setUpUsersCollectionReference() {
    usersCollection =
        firebaseFirestore.collection("users").withConverter<UserProfile>(
              fromFirestore: (snapshots, _) => UserProfile.fromJson(
                snapshots.data()!,
              ),
              toFirestore: (userProfile, _) => userProfile.toJson(),
            );
  }

  void setUpFriendRequestCollectionReference() {
    friendRequestCollection = firebaseFirestore
        .collection("friend_requests")
        .withConverter<FriendRequest>(
          fromFirestore: (snapshots, _) => FriendRequest.fromJson(
            snapshots.data()!,
          ),
          toFirestore: (friendRequest, _) => friendRequest.toJson(),
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

  Stream<QuerySnapshot<UserProfile>> getAllUserProfiles() {
    return usersCollection
        ?.where("uid", isNotEqualTo: authService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<bool> sendFriendRequest(FriendRequest friendRequest) async {
    bool result = true;
    await friendRequestCollection
        ?.doc(friendRequest.requestId) // id
        .set(friendRequest) // data
        .onError(
      (error, _) {
        debugPrint('Error uploading friend request: $error');
        result = false;
      },
    );
    return result;
  }

  Future<bool> hasSentFriendRequest(String receiverUid) async {
  final querySnapshot = await friendRequestCollection!.where(
      'senderUid', isEqualTo: authService.user!.uid
  ).where('receiverId', isEqualTo: receiverUid).get();
  return querySnapshot.docs.isNotEmpty;
}

  Stream<List<FriendRequest>> getSentFriendRequests(String senderUid) {
    return friendRequestCollection
        ?.where(senderUid, isEqualTo: authService.user!.uid)
        .snapshots() as Stream<List<FriendRequest>>;
  }

}
