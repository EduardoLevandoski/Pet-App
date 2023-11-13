import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Atendimento.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/ViewModels/AtendimentoCRUD.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaginaPetParasitas extends StatefulWidget {
  Pet pet;
  PaginaPetParasitas({super.key, required this.pet});

  @override
  State<PaginaPetParasitas> createState() => _PaginaPetParasitasState();
}

class _PaginaPetParasitasState extends State<PaginaPetParasitas> with SingleTickerProviderStateMixin {
  final AtendimentoFB _atendimento = Get.put(AtendimentoFB());

  List<Atendimento> listaPetParasitas = [];
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
    CarregaParasitas();
  }

  CarregaParasitas() async {
    setState(() {
      bCarregando = true;
    });

    listaPetParasitas = await _atendimento.buscaPetParasitasFB(idPet: widget.pet.id!);

    List<Atendimento> concludedFalse = listaPetParasitas.where((vacina) => vacina.concluida == false).toList();
    List<Atendimento> concludedTrue = listaPetParasitas.where((vacina) => vacina.concluida == true).toList();

    concludedFalse.sort((a, b) => (b.dataRepetir ?? DateTime(0)).compareTo(a.dataRepetir ?? DateTime(0))); // Most recent first
    concludedTrue.sort((a, b) => (b.dataRepetir ?? DateTime(0)).compareTo(a.dataRepetir ?? DateTime(0))); // Most recent first

    listaPetParasitas = concludedFalse + concludedTrue;

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
          : listaPetParasitas.isNotEmpty
          ? ListView.builder(
        itemCount: listaPetParasitas.length,
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          return CardParasita(index);
        },
      ): const Center(child: Text("Nenhuma medicação encontrada.")),
    );
  }

  Widget CardParasita(int index){
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
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Medicação"),
                    Text(
                        listaPetParasitas[index].medicamento
                            ?? "-",
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Status"),
                        Text(listaPetParasitas[index].concluida ?? false ? "Concluida" : "Em andamento",
                            style: TextStyle(
                                color: listaPetParasitas[index].concluida ?? false ? Colors.greenAccent : Colors.orangeAccent)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Data"),
                            Text(listaPetParasitas[index].data != null
                                ? formataDataCurta.format(listaPetParasitas[index].data!)
                                : "__/__/__"),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Peso"),
                            Text(listaPetParasitas[index].peso != null ? "${listaPetParasitas[index].peso} Kg" : "-"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Repetir em"),
                        Text(listaPetParasitas[index].dataRepetir != null
                            ? formataDataCurta.format(listaPetParasitas[index].dataRepetir!)
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

  Widget CardSkeleton(){
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
          child:const IntrinsicHeight(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Medicação"),
                      Text("----------------------------------------------------"),
                      Text("----------------------------------------------------"),
                      Text("-------------------------------------------"),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status"),
                          Text("Concluído", style: TextStyle(color: Colors.greenAccent)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Data"),
                              Text("__/__/__"),
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Peso"),
                              Text("-"),
                            ],
                          ),
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
