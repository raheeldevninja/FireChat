import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/features/account/data/datasources/account_remote_data_source.dart';
import 'package:fire_chat/features/account/data/repositories/account_repository_impl.dart';
import 'package:fire_chat/features/account/domain/repositories/account_repository.dart';
import 'package:fire_chat/features/account/domain/usecases/update_profile_use_case.dart';
import 'package:fire_chat/features/account/presentation/cubit/account_cubit.dart';
import 'package:fire_chat/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fire_chat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fire_chat/features/auth/domain/repositories/auth_repository.dart';
import 'package:fire_chat/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:fire_chat/features/auth/domain/usecases/login_usecase.dart';
import 'package:fire_chat/features/auth/domain/usecases/register_usecase.dart';
import 'package:fire_chat/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:fire_chat/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:fire_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:fire_chat/features/home/presentation/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {

  //core
  getIt.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
  );

  //firestore
  getIt.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
  );

  //auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt(), getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
  getIt.registerLazySingleton(() => SendPasswordResetEmailUseCase(getIt()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(getIt()));

  getIt.registerFactory(
          () => AuthCubit(
              repository: getIt(),
              loginUseCase: getIt(),
              registerUseCase: getIt(),
              signOutUserCase: getIt(),
              sendPasswordResetEmailUseCase: getIt(),
              changePasswordUseCase: getIt(),
          ),
  );

  //home
  getIt.registerFactory(() => HomeCubit());


  //account
  getIt.registerLazySingleton(() => AccountRemoteDataSource(getIt(), getIt()));

  getIt.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));

  getIt.registerFactory(() =>
      AccountCubit(
          updateProfileUseCase: getIt(),
      ),
  );

}

