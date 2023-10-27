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

String retornaIniciais(String text) => text.isNotEmpty
    ? text.trim().split(' ').map((l) => l[0]).take(2).join()
    : '';

PreferredSizeWidget? AppBarPadrao({required String sTitulo}) {
  return AppBar(
    title: Text(sTitulo),
  );
}

Widget CircularProgressPadrao(){
  return const SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: Colors.white,
    ),
  );
}

GetDialogSimOuNao({required String sTitulo, required String sConteudo, required onPressedSim, required onPressedNao}){
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
