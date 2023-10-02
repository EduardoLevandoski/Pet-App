import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_auth.dart';
import 'package:pet_app/Views/principal.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _controladoraCpf = TextEditingController();
  TextEditingController _controladoraEmail = TextEditingController();
  TextEditingController _controladoraSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
    User? user = await _auth.cadastroEmailSenha(email: _controladoraEmail.text, password: _controladoraSenha.text);

    if (user != null) {
      Get.offAll(() => Principal());
    }
  }
}
