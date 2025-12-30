part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error, passwordReset, passwordChanged }

class AuthState extends Equatable {

  final AuthStatus status;
  final String name;
  final String email;
  final String password;
  final String newPassword;
  final UserEntity? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
    this.newPassword = '',
    this.user,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? name,
    String? email,
    String? password,
    String? newPassword,
    UserEntity? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    name,
    user,
    email,
    password,
    newPassword,
    error,
  ];
}
