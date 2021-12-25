import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/models/usuario.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListaContatos extends StatelessWidget {
  ListaContatos({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _idUsuarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {
    _recuperarDadosUsuarioLogado();

    final userRef = _firestore.collection('usuarios');
    QuerySnapshot querySnapshot = await userRef.get();
    List<Usuario> listaUsuarios = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      String idUsuario = item['idUsuario'];

      if (idUsuario == _idUsuarioLogado) continue;

      String email = item['email'];
      String nome = item['nome'];
      String urlImagem = item['urlImagem'];

      Usuario user = Usuario(
        idUsuario,
        nome,
        email,
        urlImagem: urlImagem,
      );

      listaUsuarios.add(user);
    }
    print('lista: ${listaUsuarios.toString()}');
    return listaUsuarios;
  }

  _recuperarDadosUsuarioLogado() async {
    User? usuarioAtual = await _auth.currentUser;
    if (usuarioAtual != null) {
      _idUsuarioLogado = usuarioAtual.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:

          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: const [
                  Text('Carregando contatos'),
                  CircularProgressIndicator()
                ],
              ),
            );

          case ConnectionState.active:

          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(
                child: Text('Erro ao recuperar dados'),
              );
            } else {
              List<Usuario>? listaUsuario = snapshot.data;
              if (listaUsuario != null) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    Usuario user = listaUsuario[index];
                    return ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider(user.urlImagem),
                      ),
                      title: Text(
                        user.nome,
                        style: const TextStyle(fontSize: 20),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: listaUsuario.length,
                );
              }
            }

            return const Center(
              child: Text('Nenhum contato encontrado'),
            );
        }
      },
    );
  }
}
