import 'package:fire_chat/features/auth/domain/usecases/register_usecase.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SignOut signOutUserCase;

  late final StreamSubscription _authSub;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.signOutUserCase,
    required this.repository,
  }) : super(const AuthState()) {
    _authSub = repository.authStateChanges.listen((user) {
      if (user != null) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value, error: null, status: AuthStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, error: null, status: AuthStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, error: null, status: AuthStatus.initial));
  }

  Future<void> login() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await loginUseCase(state.email, state.password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> register() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await registerUseCase(state.name, state.email, state.password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }


  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await signOutUserCase();
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
