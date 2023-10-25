import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_auth.dart';
import 'package:pet_app/Utils/util_bottomNavigationBar.dart';
import 'package:pet_app/Views/Login/cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _controladoraEmail = TextEditingController();
  final TextEditingController _controladoraSenha = TextEditingController();

  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              const Text("Login", style: TextStyle(fontSize: 22.0)),
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
                    loginUsuario();
                  },
                  child: bCarregando ? CircularProgressPadrao() : const Text('Entrar'),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(() => Cadastro());
                },
                child: SizedBox(
                  width: RetornaLargura(context),
                  child: const Text('Cadastrar-se', textAlign: TextAlign.center),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUsuario() async {
    setState(() {
      bCarregando = true;
    });

    try {
      User? user = await _auth.loginEmailSenha(email: _controladoraEmail.text, password: _controladoraSenha.text);

      if (user != null) {
        setState(() {
          bCarregando = false;
        });

        Get.offAll(() => utilBottomNavigationBar());
      } else {
        throw ("Não foi possível encontrar esse usuário");
      }
    } catch (e) {
      setState(() {
        bCarregando = false;
      });

      Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
