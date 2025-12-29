import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fire_chat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fire_chat/features/auth/domain/repositories/auth_repository.dart';
import 'package:fire_chat/features/auth/domain/usecases/login_usecase.dart';
import 'package:fire_chat/features/auth/domain/usecases/register_usecase.dart';
import 'package:fire_chat/features/auth/domain/usecases/sign_out.dart';
import 'package:fire_chat/features/auth/presentation/cubits/auth_cubit.dart';
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
  getIt.registerLazySingleton(() => SignOut(getIt()));

  getIt.registerFactory(
          () => AuthCubit(
              repository: getIt(),
              loginUseCase: getIt(),
              registerUseCase: getIt(),
              signOutUserCase: getIt(),
          ),
  );

}

