import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  StorageService();

  Future<String?> uploadUserPfp({
    required String filePath,
    required String uid,
  }) async {
    try {
      final file = File(filePath);
      Reference fileRef = storage.ref('users/pfp').child('user_pfp').child(uid);
      UploadTask uploadTask = fileRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      debugPrint('Error uploading user pfp: $e');
      return null;
    }
  }

  Future<String?> uploadAvatarAndGetUrl({required String assetPath}) async {
    try {
      // 1. Extract the filename from the asset path:
      final fileName = path.basename(assetPath);
      final file =
          File('$assetPath-${DateTime.now().millisecondsSinceEpoch}.png');

      // 2. Create a unique file path within Firebase Storage using the user's UID:
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return null; // Handle case where user is not signed in
      }
      final avatarRef = storage.ref().child('avatars/${user.uid}/$fileName');

      // 3. Load the asset as a File:
      // final byteData = await rootBundle.load(assetPath);
      // final tempFile = File('${DateTime.now().millisecondsSinceEpoch}.png');
      // await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      // 4. Upload the image (either the asset directly or the temporary File):
      final uploadTask = avatarRef.putFile(file);

      // 5. Get the download URL after successful upload:
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      debugPrint('Error uploading avatar: $e');
      return null;
    }
  }
}
