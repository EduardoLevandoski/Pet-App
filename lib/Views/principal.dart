import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util_menu.dart';
import 'package:pet_app/Views/Paginas/pets.dart';
import 'package:pet_app/Views/Paginas/servicos.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: DrawerPadrao(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardMenuPrincipal(
                sTitulo: "Pets",
                sDescricao: "Vizualizar, editar ou cadastrar seus pets.",
                urlImagem: "assets/images/pets.jpg",
                paginaAcesso: PaginaPets()),
            CardMenuPrincipal(
                sTitulo: "Serviços",
                sDescricao: "Solicitar, editar ou cadastrar serviços ou atendimentos para seus pets.",
                urlImagem: "assets/images/pet-service.jpg",
                paginaAcesso: PaginaServicos()),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

Widget CardMenuPrincipal({
  required String sTitulo,
  required String sDescricao,
  required String urlImagem,
  required paginaAcesso,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 6.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Get.to(() => paginaAcesso);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Ink.image(
              image: AssetImage(urlImagem),
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sTitulo,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(height: 10),
                  Text(
                    sDescricao,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ),
  );
}
