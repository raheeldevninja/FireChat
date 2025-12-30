import 'package:fire_chat/core/app/style.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';
import 'package:fire_chat/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class FireChatApp extends StatelessWidget {
  const FireChatApp({required this.router, super.key});

  final RouterConfig<Object> router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'FireChat app',
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
