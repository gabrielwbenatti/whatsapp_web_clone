import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/models/mensagem.dart';
import 'package:whatsapp_web_clone/models/usuario.dart';
import 'package:whatsapp_web_clone/utils/color_pallete.dart';

class ListaMensagens extends StatefulWidget {
  const ListaMensagens({
    Key? key,
    required this.usuarioDestinatario,
    required this.usuarioRemetente,
  }) : super(key: key);

  final Usuario usuarioRemetente;
  final Usuario usuarioDestinatario;

  @override
  _ListaMensagensState createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _controllerMensagem = TextEditingController();
  late final Usuario _usuarioRemetente;
  late final Usuario _usuarioDestinatario;

  StreamController _streamController =
      StreamController<QuerySnapshot>.broadcast();
  late StreamSubscription _streamMensagem;

  @override
  void initState() {
    super.initState();
    _recuperaDadosUsuarios();
  }

  _salvarMensagem(
      String idRemetente, String idDestinatario, Mensagem mensagem) {
    _firestore
        .collection('mensagens')
        .doc(idRemetente)
        .collection(idDestinatario)
        .add(mensagem.toMap());
  }

  _enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;

    if (textoMensagem.isNotEmpty) {
      String idUserRemetente = _usuarioRemetente.idUsuario;
      Mensagem mensagem = Mensagem(
        idUserRemetente,
        textoMensagem,
        Timestamp.now().toString(),
      );

      String idUserDestinatario = _usuarioDestinatario.idUsuario;

      _salvarMensagem(idUserRemetente, idUserDestinatario, mensagem);
    }
  }

  _recuperaDadosUsuarios() {
    _usuarioRemetente = widget.usuarioRemetente;
    _usuarioDestinatario = widget.usuarioDestinatario;

    _adicionarListenerMensagens();
  }

  _adicionarListenerMensagens() {
    final stream = _firestore
        .collection('mensagens')
        .doc(_usuarioRemetente.idUsuario)
        .collection(_usuarioDestinatario.idUsuario)
        .orderBy(
          'data',
          descending: false,
        )
        .snapshots();

    _streamMensagem = stream.listen((dados) {
      _streamController.add(dados);
    });
  }

  @override
  void dispose() {
    _streamMensagem.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScren = MediaQuery.of(context).size.width;

    return Container(
      width: widthScren,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:

                case ConnectionState.waiting:
                  return Expanded(
                    child: Center(
                      child: Column(
                        children: const [
                          Text('Carregando mensagens'),
                          CircularProgressIndicator()
                        ],
                      ),
                    ),
                  );

                case ConnectionState.active:

                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro ao recuperar dados'),
                    );
                  } else {
                    QuerySnapshot querySnapshot =
                        snapshot.data as QuerySnapshot;

                    List<DocumentSnapshot> listaMensagens =
                        querySnapshot.docs.toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: querySnapshot.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mensagem = listaMensagens[index];

                          Alignment alinhamento = Alignment.bottomLeft;
                          Color cor = Colors.white;

                          if (_usuarioRemetente.idUsuario ==
                              mensagem['idUsuario']) {
                            alinhamento = Alignment.bottomRight;
                            cor = Colors.white;
                          }

                          Size largura = MediaQuery.of(context).size * 0.8;

                          return Align(
                            alignment: alinhamento,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                constraints: BoxConstraints.loose(largura),
                                decoration: BoxDecoration(
                                  color: cor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  mensagem['texto'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
              }
            },
          ),

          //caixa de mensagem
          Container(
            padding: const EdgeInsets.all(4),
            height: 60,
            color: ColorPalette.clGreyBg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //caixa de texto
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.insert_emoticon),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _controllerMensagem,
                            decoration: const InputDecoration(
                              hintText: 'Digite sua mensagem',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.attach_file),
                        const SizedBox(width: 5),
                        const Icon(Icons.camera_alt_rounded),
                      ],
                    ),
                  ),
                ),

                //botão enviar
                InkWell(
                  onTap: () {
                    _enviarMensagem();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: ColorPalette.clGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
