import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/Utils/util_cores.dart';

final formataData = DateFormat('dd/MM/yyyy');
final formataDataCurta = DateFormat('dd/MM/yy');
final formataDataComleta = DateFormat('dd/MM/yyy HH:mm');
final formataDataCompletaArquivo = DateFormat('dd-MM-yyy-HH-mm-ss');
final formataDataHora = DateFormat('HH:mm');

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

String retornaIniciais(String text) => text.isNotEmpty ? text.trim().split(' ').map((l) => l[0]).take(2).join() : '';

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

String retornaPorte(double peso) {
  if (peso < 15) {
    return "Pequeno";
  } else if (peso < 25) {
    return "Médio";
  } else {
    return "Grande";
  }
}

PreferredSizeWidget? AppBarPadrao({required String sTitulo}) {
  return AppBar(
    title: Text(sTitulo),
  );
}

Widget CircularProgressPadrao({double? dTamanho}) {
  return SizedBox(
    height: dTamanho ?? 25,
    width: dTamanho ?? 25,
    child: const CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: Colors.white,
    ),
  );
}

AlertaSimOuNao({
  required BuildContext context,
  required String sTitulo,
  required String sConteudo,
  required onPressedSim,
  required onPressedNao,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(sTitulo),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(sConteudo),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressedNao,
            child: const Text('NÃO',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                )),
          ),
          TextButton(
            onPressed: onPressedSim,
            child: Text('SIM',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: corSecundaria.withRed(0),
                )),
          ),
        ],
      );
    },
  );
}

Widget RetornaStatus(int status) {
  late String statusText;
  late Color statusCor;

  switch (status) {
    case 0:
      statusText = "Em andamento";
      statusCor = Colors.orangeAccent;
      break;
    case 1:
      statusText = "Concluído";
      statusCor = Colors.greenAccent;
      break;
    case 2:
      statusText = "Aguardando Horário do atendimento";
      statusCor = Colors.orangeAccent;
      break;
    case 3:
      statusText = "Aguardando entrega do Pet";
      statusCor = Colors.orangeAccent;
      break;
    case 4:
      statusText = "Pet pronto para buscar";
      statusCor = Colors.pinkAccent;
      break;
    case 5:
      statusText = "Cancelado";
      statusCor = Colors.redAccent;
      break;
  }

  return Text(statusText, style: TextStyle(color: statusCor, fontWeight: FontWeight.w600));
}
