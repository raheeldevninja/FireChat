import 'package:fire_chat/features/auth/presentation/auth.dart';

class ChangePasswordUseCase {

  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> call(String currentPassword, String newPassword) {
    return repository.changePassword(currentPassword: currentPassword, newPassword:  newPassword);
  }

}