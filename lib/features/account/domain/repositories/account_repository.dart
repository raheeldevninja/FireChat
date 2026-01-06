import 'package:fire_chat/shared/domain/entities/user_entity.dart';

abstract class AccountRepository {

  Future<UserEntity> updateProfile(String name);

}