import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Usuario.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Utils/util_bottomNavigationBar.dart';
import 'package:pet_app/ViewModels/UsuarioCRUD.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final UsuarioFB _usuarioFB = Get.put(UsuarioFB());

  final TextEditingController _controladoraNome = TextEditingController();
  final TextEditingController _controladoraCpf = TextEditingController();
  final TextEditingController _controladoraEmail = TextEditingController();
  final TextEditingController _controladoraSenha = TextEditingController();

  String? filePath;
  String? fileNome;
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controladoraNome.dispose();
    _controladoraCpf.dispose();
    _controladoraEmail.dispose();
    _controladoraSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Cadastro", style: TextStyle(fontSize: 22.0)),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: _controladoraNome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: _controladoraCpf,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: _controladoraEmail,
                decoration: const InputDecoration(
                  labelText: 'E-Mail',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: _controladoraSenha,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: RetornaLargura(context),
                child: ElevatedButton(
                  onPressed: () async {
                    final pick = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg'],
                    );

                    if(pick != null){
                      filePath = pick.files.single.path;
                      fileNome = pick.files.single.name;
                    }
                  },
                  child: const Text('Arquivo'),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: RetornaLargura(context),
                child: ElevatedButton(
                  onPressed: () {
                    cadastrarUsuario();
                  },
                  child: const Text('Cadastrar-se'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void cadastrarUsuario() async {
    setState(() {
      bCarregando = true;
    });


    try {
      User? user = await _auth.cadastroEmailSenha(email: _controladoraEmail.text, password: _controladoraSenha.text);

      if(filePath != null && fileNome != null) {
        await _storage.enviaArquivo(filePath: filePath!, fileNome: fileNome!);
      }

      if (user != null) {
        _usuarioFB.criaUsuarioFB(usuario: Usuario(
          uid: user.uid,
          email: _controladoraEmail.text,
          nome: _controladoraNome.text,
          cpf: _controladoraCpf.text,
          imgNome: (filePath != null && fileNome != null) ? fileNome : null,
        ));

        setState(() {
          bCarregando = false;
        });

        Get.offAll(() => utilBottomNavigationBar());
      } else {
        throw("Não fo possível cadastrar esse usuário");
      }
    } catch (e) {
      setState(() {
        bCarregando = false;
      });
      Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
