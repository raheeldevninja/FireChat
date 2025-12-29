import 'package:fire_chat/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {

  Stream<UserEntity?> get authStateChanges;

  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });


  Future<void> signOut();

}