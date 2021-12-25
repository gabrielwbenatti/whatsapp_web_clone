import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/screens/home_mobile.dart';
import 'package:whatsapp_web_clone/screens/home_web.dart';
import 'package:whatsapp_web_clone/utils/responsivo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Responsivo(
      web: HomeWeb(),
      mobile: HomeMobile(),
    );
  }
}
