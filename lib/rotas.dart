import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/screens/home_page.dart';
import 'package:whatsapp_web_clone/screens/login_screen.dart';

class Rotas {
  static Route<dynamic> gerarRota(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
    }

    return _erroRota();
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tela não encontrada'),
        ),
        body: const Center(
          child: Text('Tela não encontrada'),
        ),
      );
    });
  }
}
