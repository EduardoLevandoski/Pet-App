import 'package:flutter/material.dart';

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
