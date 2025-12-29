part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {

  final AuthStatus status;
  final String name;
  final String email;
  final String password;
  final UserEntity? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
    this.user,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? name,
    String? email,
    String? password,
    UserEntity? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
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
    error,
  ];
}
