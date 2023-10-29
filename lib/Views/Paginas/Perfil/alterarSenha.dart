import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Utils/util.dart';

class PaginaAlterarSenha extends StatefulWidget {
  bool? bLogin;

  PaginaAlterarSenha({this.bLogin = false, super.key});

  @override
  State<PaginaAlterarSenha> createState() => _PaginaAlterarSenhaState();
}

class _PaginaAlterarSenhaState extends State<PaginaAlterarSenha> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());

  final TextEditingController _controladoraEmail = TextEditingController();

  String? filePath;
  String? fileNome;
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controladoraEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPadrao(sTitulo: widget.bLogin! ? "Resgatar  senha" : "Alterar senha"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.bLogin! ? "Resgatar  senha" : "Alterar senha", style: const TextStyle(fontSize: 22.0)),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: _controladoraEmail,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: RetornaLargura(context),
                child: ElevatedButton(
                  onPressed: () {
                    FechaTeclado(context);
                    alterarSenha();
                  },
                  child: const Text('Confirmar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alterarSenha() async {
    setState(() {
      bCarregando = true;
    });

    try {
      GetAlertaSimOuNao(
          sTitulo: "Atenção",
          sConteudo:
              "Tem certeza que deseja alterar a sua senha? \n\n Será enviado ao seu email uma solicitação para alteração da senha",
          onPressedSim: () async {
            Get.back();

            setState(() {
              bCarregando = true;
            });

            if (_controladoraEmail.text.isNotEmpty) {
              await _auth.resetaSenha(email: _controladoraEmail.text);
            }

            Get.back(canPop: true);
            setState(() {
              bCarregando = false;
            });
          },
          onPressedNao: () {
            Get.back();
          });
    } catch (e) {
      setState(() {
        bCarregando = false;
      });
      Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
