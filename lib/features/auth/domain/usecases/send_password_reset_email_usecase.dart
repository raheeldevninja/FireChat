import 'package:fire_chat/features/auth/presentation/auth.dart';

class SendPasswordResetEmailUseCase {

  final AuthRepository repository;

  SendPasswordResetEmailUseCase(this.repository);

  Future<void> call(String email) {
    return repository.sendPasswordResetEmail(email: email);
  }

}