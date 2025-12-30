import 'package:fire_chat/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fire_chat/features/auth/data/models/user_dto.dart';
import 'package:fire_chat/features/auth/domain/entities/user_entity.dart';
import 'package:fire_chat/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remote;

  const AuthRepositoryImpl(this.remote);

  @override
  Stream<UserEntity?> get authStateChanges =>
      remote.authStateChanges.map((userModel) => userModel?.toEntity());

  @override
  Future<UserEntity> login({required String email, required String password}) async {
    final userDto = await remote.login(email: email, password: password);
    return userDto.toEntity();
  }

  @override
  Future<UserEntity> register({required String name, required String email, required String password}) async {

    final userDto = await remote.register(
      email: email,
      password: password,
      name: name,
    );

    await remote.createUserDocument(userDto);

    return userDto.toEntity();
  }

  @override
  Future<void> signOut() {
    return remote.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return remote.sendPasswordResetEmail(email);
  }

  @override
  Future<void> changePassword({required String currentPassword, required String newPassword}) {
    return remote.changePassword(currentPassword, newPassword);
  }

}