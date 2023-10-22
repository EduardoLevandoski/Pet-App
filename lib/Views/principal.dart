import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util_globals.dart';
import 'package:pet_app/Utils/util_menu.dart';
class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> with SingleTickerProviderStateMixin {
  utilGlobal global =  Get.find<utilGlobal>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: utilDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardMenuPrincipal(
                sTitulo: "Pets",
                sDescricao: "Vizualizar, editar ou cadastrar seus pets.",
                urlImagem: "assets/images/pets.jpg",
                paginaIndex: 1),
            CardMenuPrincipal(
                sTitulo: "Serviços",
                sDescricao: "Solicitar, editar ou cadastrar serviços ou atendimentos para seus pets.",
                urlImagem: "assets/images/pet-service.jpg",
                paginaIndex: 2),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget CardMenuPrincipal({
    required String sTitulo,
    required String sDescricao,
    required String urlImagem,
    int? paginaIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 6.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3.0,
        child: InkWell(
          onTap: () {
            if(paginaIndex != null){
              global.updateBottomNavigationBarIndex(paginaIndex);
            }
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
}