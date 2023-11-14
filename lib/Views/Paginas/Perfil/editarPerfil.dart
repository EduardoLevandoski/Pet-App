import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/Models/Usuario.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/ViewModels/UsuarioCRUD.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';
import 'package:pet_app/Views/Paginas/Perfil/alterarSenha.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

  BuscaDados() async {
    _controladoraNome.text = widget.usuario.nome!;

    if (widget.usuario.imgNome != null) {
      widget.usuario.imgUrl =
          await _storage.downloadURL(fileNome: widget.usuario.imgNome!, nomeStorageFB: NomesStorageFB.usuarios);
    }
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
                      Skeletonizer(
                        enabled: bCarregando,
                        effect: ShimmerEffect(baseColor: corCinza),
                        child: bCarregando
                            ? SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: corCinza,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Skeleton.replace(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                            "",
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            : SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: corCinza,
                                      child: (widget.usuario.imgUrl != null || filePath != null)
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
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: corPrimaria,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              final pick = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 30);

                              setState(() {
                                bCarregando = true;
                              });

                              if (pick != null) {
                                filePath = pick.path;
                                fileNome = pick.name;
                              }

                              setState(() {
                                bCarregando = false;
                              });
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
                      Get.to(() => PaginaAlterarSenha());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.5),
                      child: Text("Alterar minha senha", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: RetornaLargura(context),
                child: ElevatedButton(
                  onPressed: () {
                    FechaTeclado(context);
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
    print(_controladoraNome.text);

    try {
      AlertaSimOuNao(
          context: context,
          sTitulo: "Atenção",
          sConteudo: "Tem certeza que deseja editar seu perfil?",
          onPressedSim: () async {
            Get.back();
            setState(() {
              bCarregando = true;
            });

            String? fileStorage = widget.usuario.imgNome;

            if (filePath != null && fileNome != null) {
              if (widget.usuario.imgNome != null) {
                fileStorage = widget.usuario.imgNome!;

                await _storage.editaArquivo(
                    filePath: filePath!, fileNome: fileStorage, nomeStorageFB: NomesStorageFB.usuarios);
              } else {
                fileStorage = "${formataDataCompletaArquivo.format(DateTime.now())}_${fileNome!}";

                await _storage.enviaArquivo(
                    filePath: filePath!, fileNome: fileStorage, nomeStorageFB: NomesStorageFB.usuarios);
              }

              await _usuarioFB.editaUsuarioFB(
                  uidUsuario: widget.usuario.uid!, novoNome: widget.usuario.nome!, novoImgNome: fileStorage);
            }

            await _usuarioFB.editaUsuarioFB(
                uidUsuario: widget.usuario.uid!, novoNome: _controladoraNome.text, novoImgNome: fileStorage);
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
