import 'package:fire_chat/core/app/style.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';
import 'package:flutter/material.dart';

class FireChatApp extends StatelessWidget {
  const FireChatApp({required this.router, super.key});

  final RouterConfig<Object> router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (_) => getIt<AuthCubit>()),

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
