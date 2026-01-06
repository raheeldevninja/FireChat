import 'package:fire_chat/features/auth/presentation/auth.dart';
import 'package:fire_chat/features/account/presentation/account.dart';

class AccountRepositoryImpl implements AccountRepository {

  final AccountRemoteDataSource remote;

  const AccountRepositoryImpl(this.remote);

  @override
  Future<UserEntity> updateProfile(String name) async {
    final userDto = await remote.updateProfile(name);
    return userDto.toEntity();
  }

}