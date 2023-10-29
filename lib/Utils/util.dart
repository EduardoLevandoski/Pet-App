import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final formataData = DateFormat('dd/MM/yyyy');
final formataDataComleta = DateFormat('dd-MM-yyy-HH-mm-ss');

double RetornaAlturaTela(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double RetornaLargura(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

bool bTecladoAberto(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0;
}

void FechaTeclado(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String retornaIniciais(String text) => text.isNotEmpty
    ? text.trim().split(' ').map((l) => l[0]).take(2).join()
    : '';

String retornaIdade(DateTime data) {
  final diferenca = DateTime.now().difference(data);

  if (diferenca.inDays < 30) {
    return '${diferenca.inDays} dias';
  } else if (diferenca.inDays < 365) {
    return '${diferenca.inDays ~/ 30} mêses';
  } else {
    return '${diferenca.inDays ~/ 365} anos';
  }
}

PreferredSizeWidget? AppBarPadrao({required String sTitulo}) {
  return AppBar(
    title: Text(sTitulo),
  );
}

Widget CircularProgressPadrao({double? dTamanho}){
  return SizedBox(
    height: dTamanho ?? 25,
    width: dTamanho ?? 25,
    child: const CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: Colors.white,
    ),
  );
}

GetAlertaSimOuNao({required String sTitulo, required String sConteudo, required onPressedSim, required onPressedNao}){
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
