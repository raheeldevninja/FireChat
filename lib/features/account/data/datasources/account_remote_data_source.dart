import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/shared/data/models/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRemoteDataSource {

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AccountRemoteDataSource(this._firestore, this._auth);

  Future<UserDto> updateProfile(String name) async {
    final uid = _auth.currentUser!.uid;
      await _firestore
          .collection('users')
          .doc(uid).update({
        'name': name,
      });

    // Re-fetch or construct fresh entity
    final doc = await _firestore.collection('users').doc(uid).get();
    return UserDto.fromFireStore(doc);
  }

}