import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/components/lista_mensagens.dart';
import 'package:whatsapp_web_clone/models/usuario.dart';

class MensagensScreen extends StatefulWidget {
  const MensagensScreen(
    this.usuarioDestinatario, {
    Key? key,
  }) : super(key: key);

  final Usuario usuarioDestinatario;

  @override
  _MensagensScreenState createState() => _MensagensScreenState();
}

class _MensagensScreenState extends State<MensagensScreen> {
  late Usuario _usuarioDestinatario;

  void _recuperarDadosIniciais() {
    _usuarioDestinatario = widget.usuarioDestinatario;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosIniciais();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage:
                  CachedNetworkImageProvider(_usuarioDestinatario.urlImagem),
            ),
            const SizedBox(width: 15),
            Text(_usuarioDestinatario.nome),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: ListaMensagens(),
      ),
    );
  }
}
