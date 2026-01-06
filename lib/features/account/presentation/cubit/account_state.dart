part of 'account_cubit.dart';

enum AccountStatus { initial, loading, success, error, profileUpdated }

class AccountState extends Equatable {

  final AccountStatus status;
  final UserEntity? user;
  final String name;
  final String? error;

  const AccountState({
    this.status = AccountStatus.initial,
    this.user,
    this.name = '',
    this.error = '',
  });

  AccountState copyWith({
    AccountStatus? status,
    UserEntity? user,
    String? name,
    String? error,
  }) {
    return AccountState(
      status: status ?? this.status,
      user: user ?? this.user,
      name: name ?? this.name,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    name,
    error,
  ];

}