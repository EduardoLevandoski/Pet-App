import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/Paginas/Pet/petCadastro.dart';

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
        onPressed: () {
          Get.to(() => PaginaPetCadastro(pet: widget.pet))?.then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.edit),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: RetornaAlturaTela(context) * 0.8,
            ),
            widget.pet.imgUrl != null
                ? Image.network(
                    widget.pet.imgUrl!,
                    width: double.infinity,
                    height: RetornaAlturaTela(context) / 1.9,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: double.infinity,
                    height: RetornaAlturaTela(context) / 1.9,
                    color: corCinza,
                    child: const Center(
                        child: Icon(
                      Icons.photo,
                      size: 35,
                      color: Colors.grey,
                    ))),
            Positioned(
              top: RetornaAlturaTela(context) / 2.1,
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
                              Text(widget.pet.nome ?? "-", style: const TextStyle(fontSize: 18.0)),
                              const SizedBox(width: 5),
                              const Icon(Icons.pets_sharp)
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: ColunaConteudo(sTitulo: "Raça", sDescricao: widget.pet.raca)),
                              Expanded(
                                  flex: 2,
                                  child: ColunaConteudo(
                                      sTitulo: "Idade",
                                      sDescricao: widget.pet.idade != null ? retornaIdade(widget.pet.idade!) : null)),
                              Expanded(child: ColunaConteudo(sTitulo: "Sexo", sDescricao: widget.pet.sexo)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: ColunaConteudo(sTitulo: "Espécie", sDescricao: widget.pet.especie)),
                              Expanded(
                                  flex: 2,
                                  child: ColunaConteudo(
                                      sTitulo: "Peso",
                                      sDescricao: widget.pet.peso != null ? ("${widget.pet.peso} Kg") : "-")),
                              Expanded(
                                  child: ColunaConteudo(
                                      sTitulo: "Porte",
                                      sDescricao: widget.pet.peso != null ? retornaPorte(widget.pet.peso!) : null)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
