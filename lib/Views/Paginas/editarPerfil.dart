import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Usuario.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/ViewModels/UsuarioCRUD.dart';
import 'package:pet_app/Views/Paginas/resetarSenha.dart';

class PaginaEditarPerfil extends StatefulWidget {
  Usuario usuario;

  PaginaEditarPerfil({required this.usuario, super.key});

  @override
  State<PaginaEditarPerfil> createState() => _PaginaEditarPerfilState();
}

class _PaginaEditarPerfilState extends State<PaginaEditarPerfil> with SingleTickerProviderStateMixin {
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final UsuarioFB _usuarioFB = Get.put(UsuarioFB());

  final TextEditingController _controladoraNome = TextEditingController();

  String? filePath;
  String? fileNome;

  bool bCarregando = false;

  @override
  void initState() {
    BuscaDados();
    super.initState();
  }

  BuscaDados() {
    _controladoraNome.text = widget.usuario.nome!;
  }

  @override
  void dispose() {
    _controladoraNome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPadrao(sTitulo: "Editar perfil"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: corSecundaria,
                              child: widget.usuario.imgUrl != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: filePath != null
                                          ? Image.file(
                                              File(filePath!),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              widget.usuario.imgUrl!,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    )
                                  : Text(retornaIniciais(widget.usuario.nome!)),
                            )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: corPrimaria),
                          child: IconButton(
                            onPressed: () async {
                              final pick = await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ['png', 'jpg'],
                              );

                              if (pick != null) {
                                filePath = pick.files.single.path;
                                fileNome = pick.files.single.name;
                              }

                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Foto de perfil", style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                controller: _controladoraNome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const PaginaResetarSenha());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.5),
                      child: Text("Esqueci minha senha", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: RetornaLargura(context),
                child: ElevatedButton(
                  onPressed: () {
                    editarUsuario();
                  },
                  child: bCarregando ? CircularProgressPadrao() : const Text('Editar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editarUsuario() async {
    setState(() {
      bCarregando = true;
    });

    try {
      if (_controladoraNome.text.isNotEmpty) {
        if (filePath != null && fileNome != null) {
          await _storage.enviaArquivo(filePath: filePath!, fileNome: fileNome!);
        }

        await _usuarioFB.editaUsuarioFB(idUsuario: widget.usuario.uid!, novoNome: _controladoraNome.text, novoImgNome: fileNome);
        Get.back(canPop: true);
      }

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
