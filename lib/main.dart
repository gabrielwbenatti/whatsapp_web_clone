import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/firebase_options.dart';
import 'package:whatsapp_web_clone/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      title: 'WhatsApp Web Clone',
      home: LoginScreen(),
    ),
  );
}
