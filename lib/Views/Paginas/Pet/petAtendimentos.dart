import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Atendimento.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/ViewModels/AtendimentoCRUD.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaginaPetAtendimento extends StatefulWidget {
  Pet pet;

  PaginaPetAtendimento({super.key, required this.pet});

  @override
  State<PaginaPetAtendimento> createState() => _PaginaPetAtendimentoState();
}

class _PaginaPetAtendimentoState extends State<PaginaPetAtendimento> with SingleTickerProviderStateMixin {
  final AtendimentoFB _atendimento = Get.put(AtendimentoFB());

  List<Atendimento> listaPetAtendimentos = [];
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

    listaPetAtendimentos = await _atendimento.buscaPetAtendimentoFB(idPet: widget.pet.id!);

    List<Atendimento> sortByStatus(List<Atendimento> atendimentos, int status) {
      List<Atendimento> filteredList = atendimentos.where((atendimento) => atendimento.status == status).toList();
      filteredList.sort((a, b) => (b.data ?? DateTime(0)).compareTo(a.data ?? DateTime(0)));
      return filteredList;
    }

    List<Atendimento> aguardandoPet = sortByStatus(listaPetAtendimentos, 3);
    List<Atendimento> aguardandoDono = sortByStatus(listaPetAtendimentos, 4);
    List<Atendimento> aguardandoHorario = sortByStatus(listaPetAtendimentos, 2);
    List<Atendimento> emAndamento = sortByStatus(listaPetAtendimentos, 0);
    List<Atendimento> concluido = sortByStatus(listaPetAtendimentos, 1);
    List<Atendimento> cancelado = sortByStatus(listaPetAtendimentos, 5);

    listaPetAtendimentos = aguardandoPet + aguardandoDono + aguardandoHorario + emAndamento + concluido + cancelado;

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
          : listaPetAtendimentos.isNotEmpty
          ? ListView.builder(
        itemCount: listaPetAtendimentos.length,
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          return CardAtendimento(index);
        },
      ) : const Center(child: Text("Nenhum atendimento encontrado.")),
    );
  }

  Widget CardAtendimento(int index) {
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
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Servico"),
                    Text(
                        listaPetAtendimentos[index].servico
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
                        RetornaStatus(listaPetAtendimentos[index].status ?? 0),
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
                            Text(listaPetAtendimentos[index].data != null
                                ? formataDataComleta.format(listaPetAtendimentos[index].data!)
                                : "__/__/__"),
                          ],
                        ),

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
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Servico"),
                      Text("----------------------------"),
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
                          Text("---------------------", style: TextStyle(color: Colors.greenAccent)),
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
