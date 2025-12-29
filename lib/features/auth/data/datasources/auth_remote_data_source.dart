import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/features/auth/data/models/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._auth, this._firestore);

  Stream<UserDto?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) async {

      if (user == null) return null;

      // Always check FireStore first
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserDto.fromFireStore(doc);
      }

      // fallback if FireStore doc missing
      return UserDto(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
    });
  }


  Future<UserDto> login({required String email, required String password}) async {

    try {

      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user!;

      return UserDto(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? '',
      );

    }
    on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
    catch(e) {
      throw 'An error occurred: ${e.toString()}';
    }

  }


  Future<UserDto> register({required String name, required String email, required String password}) async {

    try {

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('User creation failed');
      }

      // Update Firebase profile
      await user.updateDisplayName(name);
      await user.reload();

      return UserDto(
        id: user.uid,
        email: email,
        name: name,
      );

    }
    on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
    catch(e) {
      throw 'An error occurred: ${e.toString()}';

    }

  }

  Future<void> createUserDocument(UserDto user) {
    return _firestore.collection('users').doc(user.id).set(user.toDocument());
  }


  Future<void> signOut() {
    return _auth.signOut();
  }

  String _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Invalid credential';
      case 'invalid-email':
        return 'The email address is invalid';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'too-many-requests':
        return 'Too many requests.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }


}