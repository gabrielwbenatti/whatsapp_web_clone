import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_web_clone/rotas.dart';
import 'package:whatsapp_web_clone/utils/color_pallete.dart';

final ThemeData temaPadrao = ThemeData(
  appBarTheme: const AppBarTheme(
    color: ColorPalette.clGreen,
  ),
);

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: 'WhatsApp Web Clone',
      theme: temaPadrao,
      // home: LoginScreen(),
      initialRoute: '/login',
      onGenerateRoute: Rotas.gerarRota,
    ),
  );
}
