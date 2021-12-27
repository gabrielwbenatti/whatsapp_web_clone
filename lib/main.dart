import 'package:firebase_auth/firebase_auth.dart';
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

  User? usuarioFirebase = FirebaseAuth.instance.currentUser;
  String urlInicial = '/';

  if (usuarioFirebase != null) {
    urlInicial = '/home';
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Web Clone',
      theme: temaPadrao,
      // home: LoginScreen(),
      initialRoute: urlInicial,
      onGenerateRoute: Rotas.gerarRota,
    ),
  );
}
