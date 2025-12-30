import 'package:fire_chat/core/app/go_router_refresh_stream.dart';
import 'package:fire_chat/features/account/presentation/page/account_page.dart';
import 'package:fire_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:fire_chat/features/auth/presentation/pages/change_password_page.dart';
import 'package:fire_chat/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:fire_chat/features/auth/presentation/pages/login_page.dart';
import 'package:fire_chat/features/auth/presentation/pages/register_page.dart';
import 'package:fire_chat/features/auth/presentation/pages/splash_page.dart';
import 'package:fire_chat/features/chat_rooms/presentation/pages/chat_room_page.dart';
import 'package:fire_chat/features/home/presentation/cubit/home_cubit.dart';
import 'package:fire_chat/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GoRouter createRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final authState = authCubit.state;

      // While still initializing, stay on splash
      if (authState.status == AuthStatus.initial) {
        return state.fullPath == '/splash' ? null : '/splash';
      }

      // Authenticated → go home
      if (authState.status ==  AuthStatus.authenticated) {
        if (state.fullPath == '/login' ||
            state.fullPath == '/register' ||
            state.fullPath == '/forgot-password' ||
            state.fullPath == '/splash') {

          context.read<HomeCubit>().currentIndexChanged(0);

          return '/chat-rooms';
        }

        return null; // allow current route
      }

      // Unauthenticated → force to sign in
      if (authState.status ==  AuthStatus.unauthenticated) {
        if (state.fullPath != '/login' &&
            state.fullPath != '/register' &&
            state.fullPath != '/forgot-password') {
          return '/login';
        }
      }

      return null;
    },
    routes: [

      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),


      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),

      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      ShellRoute(
          builder: (context, state, child) => HomePage(child: child),
          routes: [
            GoRoute(
                path: '/chat-rooms',
                builder: (context, state) => ChatRoomPage(),
            ),
            GoRoute(
              path: '/account-page',
              builder: (context, state) => AccountPage(),
            ),
          ]
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordPage(),
      ),

    ],
  );
}
