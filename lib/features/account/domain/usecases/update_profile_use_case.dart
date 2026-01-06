import 'package:fire_chat/features/account/presentation/account.dart';

class UpdateProfileUseCase {

  final AccountRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<UserEntity> call(String name) {
    return repository.updateProfile(name);
  }

}