import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/Login/login.dart';

Widget utilDrawer(context) {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());

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
            sPagina: "Configurações",
            icone: Icons.settings,
            onTap: () {
              Navigator.of(context).pop(context);
            }),
        RetornaTileDrawer(
            sPagina: "Sair",
            icone: Icons.exit_to_app,
            onTap: () {
              _auth.logout();
              Navigator.of(context).pop(context);
              Get.offAll(() => const Login());
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
