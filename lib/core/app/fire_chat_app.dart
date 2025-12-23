import 'package:fire_chat/core/app/style.dart';
import 'package:fire_chat/features/chat_rooms/presentation/pages/chat_room_page.dart';
import 'package:flutter/material.dart';

class FireChatApp extends StatelessWidget {
  const FireChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FireChat app',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const ChatRoomPage(),
    );
  }
}
