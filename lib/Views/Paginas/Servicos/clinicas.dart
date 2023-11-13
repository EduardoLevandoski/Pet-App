import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Clinica.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/ViewModels/ClinicaCRUD.dart';
import 'package:pet_app/Views/Paginas/Servicos/servicos.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaginaClinicas extends StatefulWidget {
  const PaginaClinicas({super.key});

  @override
  State<PaginaClinicas> createState() => _PaginaClinicasState();
}

class _PaginaClinicasState extends State<PaginaClinicas> with SingleTickerProviderStateMixin {
  final ClinicaFB _clinica = Get.put(ClinicaFB());

  List<Clinica> listaClinicas = [];
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

    listaClinicas = await _clinica.buscaClinicasFB();

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
          : listaClinicas.isNotEmpty
              ? ListView.builder(
                  itemCount: listaClinicas.length,
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    return CardClinica(index);
                  },
                )
              : const Center(child: Text("Nenhuma clínica encontrada.")),
    );
  }

  Widget CardClinica(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: InkWell(
        onTap: (){
          Get.to(() => PaginaServicos(clinica: listaClinicas[index],));
        },
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: corBranca,
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
                Icon(Icons.store, color: corPrimaria, size: 40.0),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listaClinicas[index].nomeFantasia ?? "-"),
                      Text(listaClinicas[index].telefone ?? "-", style: const TextStyle(fontSize: 12.0)),
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
                Icon(Icons.store),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("-------------------------------------"),
                      Text("-----------"),
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
