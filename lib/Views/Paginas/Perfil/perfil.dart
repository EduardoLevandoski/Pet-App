import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/Models/Usuario.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Utils/util_globals.dart';
import 'package:pet_app/ViewModels/UsuarioCRUD.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';
import 'package:pet_app/Views/Login/login.dart';
import 'package:pet_app/Views/Paginas/Perfil/editarPerfil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaginaPerfil extends StatefulWidget {
  PaginaPerfil({super.key});

  @override
  State<PaginaPerfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<PaginaPerfil> {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final UsuarioFB _usuarioFB = Get.put(UsuarioFB());
  utilGlobal global = Get.find<utilGlobal>();

  Usuario? usuario;
  bool bCarregando = false;

  String? filePath;
  String? fileNome;

  @override
  void initState() {
    super.initState();
    BuscaDados();
  }

  BuscaDados() async {
    setState(() {
      bCarregando = true;
    });

    try {
      User? user = await _auth.getUsuarioAtual();

      if (user != null) {
        usuario = await _usuarioFB.buscaUsuarioPorIdFB(idUsuario: user.uid);

        if (usuario!.imgNome != null) {
          usuario!.imgUrl = await _storage.downloadURL(fileNome: usuario!.imgNome!, nomeStorageFB: NomesStorageFB.usuarios);
        }
      } else {
        throw ("Não foi possível encontrar o usuário atual");
      }
    } catch (e) {
      Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }

    setState(() {
      bCarregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                                  child: usuario!.imgUrl != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.network(
                                            usuario!.imgUrl!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Text(bCarregando ? "" : retornaIniciais(usuario!.nome!)),
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
                          borderRadius: BorderRadius.circular(100), color: bCarregando ? Colors.grey : corPrimaria),
                      child: IconButton(
                        onPressed: bCarregando
                            ? null
                            : () async {
                                try {
                                  final pick = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 30);

                                  if (pick != null) {
                                    filePath = pick.path;
                                    fileNome = pick.name;
                                  }

                                  String? fileStorage;

                                  if (filePath != null && fileNome != null) {
                                    if(usuario?.imgNome != null) {
                                      fileStorage = usuario!.imgNome!;

                                      await _storage.editaArquivo(
                                          filePath: filePath!, fileNome: fileStorage, nomeStorageFB: NomesStorageFB.usuarios);
                                    } else {
                                      fileStorage = "${formataDataCompletaArquivo.format(DateTime.now())}_${fileNome!}";

                                      await _storage.enviaArquivo(
                                          filePath: filePath!, fileNome: fileStorage, nomeStorageFB: NomesStorageFB.usuarios);
                                    }

                                    await _usuarioFB.editaUsuarioFB(uidUsuario: usuario!.uid!, novoNome: usuario!.nome!, novoImgNome: fileStorage);
                                  }

                                  BuscaDados();
                                } catch (e) {
                                  Get.snackbar("Erro", e.toString(),
                                      backgroundColor: Colors.redAccent, colorText: Colors.white);
                                }
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
              const SizedBox(height: 10),
              Skeletonizer(
                  enabled: bCarregando,
                  effect: ShimmerEffect(baseColor: corCinza),
                  child: Text(bCarregando ? "----------------------" : usuario!.nome!)),
              Skeletonizer(
                  enabled: bCarregando,
                  effect: ShimmerEffect(baseColor: corCinza),
                  child: Text(bCarregando ? "-----------------------------------" : usuario!.email!)),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: bCarregando
                      ? null
                      : () {
                          Get.to(() => PaginaEditarPerfil(usuario: usuario!))?.then((value) {
                            BuscaDados();
                          });
                        },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: corPrimaria, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("Editar Perfil"),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              CampoMenu(
                  sTitulo: "Sair",
                  icone: Icons.exit_to_app,
                  onPress: bCarregando
                      ? null
                      : () {
                          AlertaSimOuNao(
                            context: context,
                            sTitulo: "Atenção",
                            sConteudo: "Tem certeza que deseja sair?",
                            onPressedSim: () {
                              _auth.logout();
                              global.updateBottomNavigationBarIndex(0);
                              Navigator.of(context).pop(context);
                              Get.offAll(() => const Login());
                            },
                            onPressedNao: () {
                              Get.back();
                            },
                          );
                        }),
            ],
          ),
        ),
      ),
    );
  }

  Widget CampoMenu({required String sTitulo, required IconData icone, dynamic onPress}) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.1),
        ),
        child: Icon(icone, color: corPrimaria),
      ),
      title: Text(sTitulo, style: TextStyle(color: bCarregando ? Colors.grey : Colors.black)),
    );
  }
}
