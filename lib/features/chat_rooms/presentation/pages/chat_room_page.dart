import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Rooms'),
      ),
      body: Center(
        child: Text('Chat Rooms Page'),
      ),
    );
  }
}