import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Atendimento.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/ViewModels/AtendimentoCRUD.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaginaPetVacinas extends StatefulWidget {
  Pet pet;

  PaginaPetVacinas({super.key, required this.pet});

  @override
  State<PaginaPetVacinas> createState() => _PaginaPetVacinasState();
}

class _PaginaPetVacinasState extends State<PaginaPetVacinas> with SingleTickerProviderStateMixin {
  final AtendimentoFB _atendimento = Get.put(AtendimentoFB());

  List<Atendimento> listaPetVacinas = [];
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
    CarregaVacinas();
  }

  CarregaVacinas() async {
    setState(() {
      bCarregando = true;
    });

    listaPetVacinas = await _atendimento.buscaPetVacinasFB(idPet: widget.pet.id!);

    List<Atendimento> concludedFalse = listaPetVacinas.where((vacina) => vacina.concluida == false).toList();
    List<Atendimento> concludedTrue = listaPetVacinas.where((vacina) => vacina.concluida == true).toList();

    concludedFalse.sort((a, b) => (b.dataRepetir ?? DateTime(0)).compareTo(a.dataRepetir ?? DateTime(0))); // Most recent first
    concludedTrue.sort((a, b) => (b.dataRepetir ?? DateTime(0)).compareTo(a.dataRepetir ?? DateTime(0))); // Most recent first

    listaPetVacinas = concludedFalse + concludedTrue;

    setState(() {
      bCarregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bCarregando
          ? ListView.builder(
              itemCount: 3,
              padding: const EdgeInsets.only(bottom: 80),
              itemBuilder: (context, index) {
                return CardSkeleton();
              },
            )
          : listaPetVacinas.isNotEmpty
              ? ListView.builder(
                  itemCount: listaPetVacinas.length,
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    return CardVacina(index);
                  },
                )
              : const Center(child: Text("Nenhuma vacina encontrada.")),
    );
  }

  Widget CardVacina(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7, // changes position of shadow
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Vacina"),
                    Text(
                        listaPetVacinas[index].vacina
                            ?? "-",
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Status"),
                        Text(listaPetVacinas[index].concluida ?? false ? "Concluida" : "Em andamento",
                            style: TextStyle(
                                color: listaPetVacinas[index].concluida ?? false ? Colors.greenAccent : Colors.orangeAccent)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Data"),
                        Text(listaPetVacinas[index].data != null
                            ? formataDataCurta.format(listaPetVacinas[index].data!)
                            : "__/__/__"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Repetir em"),
                        Text(listaPetVacinas[index].dataRepetir != null
                            ? formataDataCurta.format(listaPetVacinas[index].dataRepetir!)
                            : "__/__/__"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 7, // changes position of shadow
              ),
            ],
          ),
          child: const IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Vacina"),
                      Text("----------------------------------------------------"),
                      Text("----------------------------------------------------"),
                      Text("-------------------------------------------"),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status"),
                          Text("Em andamento", style: TextStyle(color: Colors.orangeAccent)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Data"),
                          Text("__/__/__"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Repetir em"),
                          Text("__/__/__"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
