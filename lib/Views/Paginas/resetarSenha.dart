import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Usuario.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/ViewModels/UsuarioCRUD.dart';

class PaginaResetarSenha extends StatefulWidget {
  const PaginaResetarSenha({super.key});

  @override
  State<PaginaResetarSenha> createState() => _PaginaResetarSenhaState();
}

class _PaginaResetarSenhaState extends State<PaginaResetarSenha> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final UsuarioFB _usuarioFB = Get.put(UsuarioFB());

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
      appBar: AppBarPadrao(sTitulo: "Resetar senha"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Resetar senha", style: TextStyle(fontSize: 22.0)),
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
                    resetarSenha();
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

  void resetarSenha() async {
    setState(() {
      bCarregando = true;
    });

    try {
      setState(() {
        bCarregando = false;
      });
    } catch (e) {
      setState(() {
        bCarregando = false;
      });
      Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
