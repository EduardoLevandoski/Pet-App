import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/Utils/util_cores.dart';

double RetornaAlturaTela(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double RetornaLargura(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

PreferredSizeWidget? AppBarPadrao({required String sTitulo}) {
  return AppBar(
    title: Text(sTitulo),
  );
}

Widget CardMenuPrincipal({
  required String sTitulo,
  required String sDescricao,
  required String urlImagem,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: InkWell(
      onTap: () {},
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
  );
}
