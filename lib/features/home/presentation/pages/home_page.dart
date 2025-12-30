import 'package:fire_chat/features/auth/presentation/auth.dart';
import 'package:fire_chat/features/home/presentation/home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {

        int currentIndex = state.currentIndex;

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (int index) {
              context.read<HomeCubit>().currentIndexChanged(index);

              switch(index) {
                case 0:
                  context.go('/chat-rooms');
                  break;
                case 1:
                  context.go('/account-page');
                  break;
              }

            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat-Rooms',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
