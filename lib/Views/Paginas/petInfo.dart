import 'package:flutter/material.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';

class PaginaPetInfo extends StatefulWidget {
  Pet pet;

  PaginaPetInfo({super.key, required this.pet});

  @override
  State<PaginaPetInfo> createState() => _PaginaPetInfoState();
}

class _PaginaPetInfoState extends State<PaginaPetInfo> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Editar pet",
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: RetornaAlturaTela(context) * 1.1,
            ),
            Image.asset(
              widget.pet.petImgUrl ?? "",
              width: double.infinity,
              height: RetornaAlturaTela(context) / 1.9,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: RetornaAlturaTela(context) / 2.2,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.pet.petNome, style: const TextStyle(fontSize: 18.0)),
                              const SizedBox(width: 5),
                              const Icon(Icons.pets_sharp)
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: ColunaConteudo(sTitulo: "Raça", sDescricao: widget.pet.petRaca)),
                              Expanded(
                                  flex: 2,
                                  child: ColunaConteudo(
                                      sTitulo: "Idade",
                                      sDescricao:
                                          widget.pet.petIdade != null ? "${widget.pet.petIdade!.month} mêses" : null)),
                              Expanded(child: ColunaConteudo(sTitulo: "Sexo", sDescricao: widget.pet.petSexo)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: ColunaConteudo(sTitulo: "Espécie", sDescricao: widget.pet.petEspecie)),
                              Expanded(flex: 2, child: ColunaConteudo(sTitulo: "Peso", sDescricao: widget.pet.petPeso)),
                              Expanded(child: ColunaConteudo(sTitulo: "Cor", sDescricao: widget.pet.petCor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LinhaConteudo(sTitulo: "Tutor", sDescricao: null),
                          const Divider(),
                          LinhaConteudo(sTitulo: "Endereço", sDescricao: null),
                          const Divider(),
                          LinhaConteudo(sTitulo: "Cidade", sDescricao: null),
                          const Divider(),
                          LinhaConteudo(sTitulo: "Estado", sDescricao: null),
                          const Divider(),
                          LinhaConteudo(sTitulo: "Telefone", sDescricao: null),
                          const Divider(),
                          LinhaConteudo(sTitulo: "Celular", sDescricao: null),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

Widget LinhaConteudo({required String sTitulo, String? sDescricao}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(sTitulo, style: const TextStyle(fontSize: 16.0)),
      Text(sDescricao ?? "-", style: const TextStyle(color: Colors.grey), textAlign: TextAlign.center, maxLines: 1),
    ],
  );
}

Widget ColunaConteudo({required String sTitulo, String? sDescricao}) {
  return Column(
    children: [
      Text(sTitulo, style: const TextStyle(fontSize: 18.0)),
      Text(sDescricao ?? "-", style: const TextStyle(color: Colors.grey), textAlign: TextAlign.center, maxLines: 2),
    ],
  );
}
