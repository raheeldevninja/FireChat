import 'package:fire_chat/features/auth/domain/repositories/auth_repository.dart';
import 'package:fire_chat/shared/domain/entities/user_entity.dart';

class RegisterUseCase {

  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call(String name, String email, String password) {
    return repository.register(name: name, email: email, password: password);
  }

}