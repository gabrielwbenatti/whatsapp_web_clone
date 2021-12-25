import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/components/lista_contatos.dart';
import 'package:whatsapp_web_clone/utils/color_pallete.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.login_outlined),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: ColorPalette.clWhite,
            indicatorWeight: 4,
            tabs: [
              Tab(text: 'Conversas'),
              Tab(text: 'Contatos'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(children: [
            const Text('conversas'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListaContatos(),
            ),
          ]),
        ),
      ),
    );
  }
}
