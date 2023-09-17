import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal>
    with SingleTickerProviderStateMixin {
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
      drawer: const Drawer(
          shadowColor: Colors.white, shape: BeveledRectangleBorder()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 6.0),
              child: CardMenuPrincipal(
                  sTitulo: "Pets",
                  sDescricao: "Vizualizar, editar ou cadastrar seus pets.",
                  urlImagem: "assets/images/pets.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 6.0),
              child: CardMenuPrincipal(
                  sTitulo: "Serviços",
                  sDescricao:
                      "Solicitar, editar ou cadastrar serviços ou atendimentos para seus pets.",
                  urlImagem: "assets/images/pet-service.jpg"),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
