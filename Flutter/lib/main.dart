import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0B1739),
        scaffoldBackgroundColor: const Color(0xFF0B1739),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B1739),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFCB3CFF),
          secondary: const Color(0xFF9A91FB),
          surface: const Color(0xFF0B1739),
        ),
        fontFamily: 'Inter',
      ),
      home: const ChatScreen(),
    );
  }
}