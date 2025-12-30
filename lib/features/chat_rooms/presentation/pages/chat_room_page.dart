import 'package:flutter/material.dart';
import 'package:fire_chat/features/chat_rooms/presentation/chatrooms.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Rooms')),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {

          if(state.status == AuthStatus.authenticated) {
            final user = state.user;
            final initials = _getInitials(user?.name);

            return Column(
              children: [
                //header
                Container(
                  padding: const EdgeInsets.all(16),
                  color: context.colorScheme.surfaceContainer,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: context.colorScheme.secondary,
                        child: Text(
                          initials,
                          style: context.textTheme.titleLarge!.copyWith(
                            color: context.colorScheme.onPrimaryFixed,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user?.name ?? 'NA', style: context.textTheme.bodyLarge),
                          Text(user?.email ?? 'NA', style: context.textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );

          }

          return const SizedBox.shrink();


        },
      ),
    );
  }

  String _getInitials(String? text) {
    if (text == null || text.isEmpty) return "?";

    final parts = text.trim().split(" ");

    if (parts.length == 1) return parts[0][0].toUpperCase();

    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }

}
