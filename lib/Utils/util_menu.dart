import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/Login/login.dart';
import 'package:pet_app/Views/Paginas/pets.dart';
import 'package:pet_app/Views/Paginas/servicos.dart';

Widget DrawerPadrao(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: corPrimaria),
          accountName: const Text(
            "Pinkesh Darji",
            style: TextStyle(fontSize: 14.0),
          ),
          accountEmail: const Text(
            "pinkesh.earth@gmail.com",
            style: TextStyle(fontSize: 12.0),
          ),
          currentAccountPicture: CircleAvatar(
            radius: 25,
            backgroundColor: corSecundaria,
            child: const Text("PD", style: TextStyle(color: Colors.white)),
          ),
        ),
        RetornaTileDrawer(
            sPagina: "Pets",
            icone: Icons.pets,
            onTap: () {
              Navigator.of(context).pop(context);
              Get.to(PaginaPets());
            }),
        RetornaTileDrawer(
            sPagina: "Serviços",
            icone: Icons.bathtub,
            onTap: () {
              Navigator.of(context).pop(context);
              Get.to(PaginaServicos());
            }),
        RetornaTileDrawer(
            sPagina: "Sair",
            icone: Icons.exit_to_app,
            onTap: () {
              Navigator.of(context).pop(context);
              Get.offAll(Login());
            }),
      ],
    ),
  );
}

Widget RetornaTileDrawer({
  required String sPagina,
  required IconData icone,
  Function()? onTap,
}) {
  return ListTile(
    leading: Icon(
      icone,
    ),
    title: Text(sPagina),
    onTap: onTap,
  );
}
