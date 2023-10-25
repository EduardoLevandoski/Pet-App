import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Usuario.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_auth.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Utils/util_globals.dart';
import 'package:pet_app/ViewModels/UsuarioCRUD.dart';
import 'package:pet_app/Views/Login/login.dart';


class PaginaPerfil extends StatefulWidget {
  PaginaPerfil({super.key});

  @override
  State<PaginaPerfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<PaginaPerfil> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final UsuarioFB _usuarioFB = Get.put(UsuarioFB());
  utilGlobal global =  Get.find<utilGlobal>();

  Usuario? usuario;
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
    BuscaDados();
  }

  BuscaDados() async {
    setState(() {
      bCarregando = true;
    });

    try{
      usuario = await _usuarioFB.buscaUsuarioPorIdFB(idUsuario: "68NFVwa9xEca3qWdbI4CvUwG4FD2");
    } catch (e) {
      Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }

    if (usuario != null) {
      setState(() {
        bCarregando = false;
      });
    }
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
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: corSecundaria,
                          child: const Text("US", style: TextStyle(color: Colors.white)),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: corPrimaria),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(usuario!.nome!),
              Text(usuario!.email!),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: corPrimaria, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("Editar Perfil"),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              CampoMenu(sTitulo: "Configurações", icone: Icons.settings, onPress: () {}),
              const Divider(),
              CampoMenu(
                  sTitulo: "Sair",
                  icone: Icons.exit_to_app,
                  onPress: () {
                    GetDialogSimOuNao(
                      sTitulo: "Sim",
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
      title: Text(sTitulo),
    );
  }
}
