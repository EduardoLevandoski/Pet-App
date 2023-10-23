import 'package:flutter/material.dart';
import 'package:get/get.dart';

double RetornaAlturaTela(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double RetornaLargura(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

bool bTecladoAberto(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0;
}

PreferredSizeWidget? AppBarPadrao({required String sTitulo}) {
  return AppBar(
    title: Text(sTitulo),
  );
}

GetDialogSimNao({required String sTitulo, required String sConteudo, required onPressedSim, required onPressedNao}){
  return Get.defaultDialog(
    titlePadding: const EdgeInsets.only(top: 15),
    title: sTitulo,
    titleStyle: const TextStyle(fontSize: 20),
    backgroundColor: Colors.white,
    content: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(sConteudo),
    ),
    confirm: ElevatedButton(
      onPressed: onPressedSim,
      child: const Text("Sim"),
    ),
    cancel: OutlinedButton(
      onPressed: onPressedNao,
      child: const Text("Não"),
    ),
  );
}
