import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/principal.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TextEditingController controladoraUsuario = TextEditingController();
  TextEditingController controladoraSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              const Text("Login", style: TextStyle(fontSize: 22.0)),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: controladoraUsuario,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: controladoraSenha,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: RetornaLargura(context),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(Principal());
                  },
                  child: const Text('Entrar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
