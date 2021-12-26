import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/utils/color_pallete.dart';

class ListaMensagens extends StatefulWidget {
  const ListaMensagens({Key? key}) : super(key: key);

  @override
  _ListaMensagensState createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {
  @override
  Widget build(BuildContext context) {
    double widthScren = MediaQuery.of(context).size.width;

    return Container(
      width: widthScren,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('images/bg.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Column(
        children: [
          //TODO: lista de mensagens
          Expanded(child: Container(color: Colors.red)),

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
                      children: const [
                        Icon(Icons.insert_emoticon),
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Digite sua mensagem',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.attach_file),
                        SizedBox(width: 5),
                        Icon(Icons.camera_alt_rounded),
                      ],
                    ),
                  ),
                ),

                //botão enviar
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: ColorPalette.clGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
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
