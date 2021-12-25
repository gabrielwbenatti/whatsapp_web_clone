import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/utils/color_pallete.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _contollerName =
      TextEditingController(text: 'Gabriel');
  final TextEditingController _contollerEmail =
      TextEditingController(text: 'gabriel@gmail.com');
  final TextEditingController _contollerPassowrd =
      TextEditingController(text: '12346');

  bool _newRegister = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Uint8List? _selectedImageFile;

  _dataValidation() async {
    String name = _contollerName.text;
    String email = _contollerEmail.text;
    String password = _contollerPassowrd.text;

    if (email.isNotEmpty && email.contains('@')) {
      if (password.isNotEmpty && password.length > 6) {
        if (_newRegister) {
          if (name.isNotEmpty && name.length > 2) {
            await _auth
                .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
                .then((auth) {
              String? userId = auth.user?.uid;

              print('Usuario cadastrado $userId');
            });
          } else {
            print('Nome inválido');
          }
        } else {
          await _auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((auth) {
            String? userEmail = auth.user?.email;

            print('Usuario logado $userEmail');
          });
        }
      } else {
        print('Senha inválida');
      }
    } else {
      print('E-mail inválido');
    }
  }

  void _selectImage() async {
    //selecionar o arquivo
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(type: FileType.image);

    setState(() {
      _selectedImageFile = file?.files.single.bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      color: ColorPalette.clWhite,
      width: widthScreen,
      height: heightScreen,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: ColorPalette.clGreen,
              width: widthScreen / 2,
              height: heightScreen / 2,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  // height: heightScreen * 0.5,
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100],
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Container(
                    width: 500,
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Visibility(
                          visible: _newRegister,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: ClipOval(
                                  child: _selectedImageFile != null
                                      ? Image.memory(
                                          _selectedImageFile!,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorPalette.clWhite,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Colors.black54,
                                              size: 60,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              OutlinedButton(
                                onPressed: _selectImage,
                                child: const Text('Selecionar foto'),
                              ),
                              const SizedBox(height: 20),
                              Material(
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _contollerName,
                                  decoration: const InputDecoration(
                                    hintText: 'Nome',
                                    labelText: 'Nome',
                                    suffixIcon: Icon(Icons.person_outlined),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _contollerEmail,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              suffixIcon: Icon(Icons.mail_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          child: TextField(
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: _contollerPassowrd,
                            decoration: const InputDecoration(
                              hintText: 'Senha',
                              labelText: 'Senha',
                              suffixIcon: Icon(Icons.lock_outline),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: ColorPalette.clGreen),
                            onPressed: _dataValidation,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(_newRegister ? 'Cadastrar' : 'Login'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          child: Row(
                            children: [
                              const Text('Login'),
                              Switch(
                                value: _newRegister,
                                onChanged: (value) {
                                  setState(() {
                                    _newRegister = !_newRegister;
                                  });
                                },
                                activeColor: ColorPalette.clGreen,
                                inactiveThumbColor: ColorPalette.clWhite,
                              ),
                              const Text('Cadastro'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
