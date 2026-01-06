import 'package:fire_chat/features/account/presentation/account.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {

  final UpdateProfileUseCase updateProfileUseCase;

  AccountCubit({required this.updateProfileUseCase}) : super(AccountState());

  void nameChanged(String value) {
    emit(state.copyWith(name: value, error: null, status: AccountStatus.initial));
  }

  void updateProfile() async {

    emit(state.copyWith(status: AccountStatus.loading));

    try {
      final updatedUser = await updateProfileUseCase(state.name);
      emit(state.copyWith(status: AccountStatus.profileUpdated, user: updatedUser));
    }
    catch(e) {
     emit(state.copyWith(status: AccountStatus.error, error: e.toString()));
    }

  }

}