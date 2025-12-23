import 'package:fire_chat/core/app/fire_chat_app.dart';
import 'package:fire_chat/core/di/injections.dart';
import 'package:fire_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();

  runApp(const FireChatApp());
}
