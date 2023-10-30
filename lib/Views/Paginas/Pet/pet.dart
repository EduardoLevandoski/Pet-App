import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Views/Paginas/Pet/petAtendimentos.dart';
import 'package:pet_app/Views/Paginas/Pet/petParasitas.dart';
import 'package:pet_app/Views/Paginas/Pet/petInfo.dart';
import 'package:pet_app/Views/Paginas/Pet/petVacinas.dart';

class PaginaPet extends StatefulWidget {
  Pet pet;

  PaginaPet({super.key, required this.pet});

  @override
  State<PaginaPet> createState() => _PaginaPetState();
}

class _PaginaPetState extends State<PaginaPet> with SingleTickerProviderStateMixin {
  bool bPetEditado = false;

  List<Tab> listaAbas = [
    const Tab(text: "PET"),
    const Tab(text: "CONTROLE DE VACINAÇÃO"),
    const Tab(text: "CONTROLE DE PARASITAS"),
    const Tab(text: "ATENDIMENTOS"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(canPop: true);
        return true;
      },
      child: DefaultTabController(
        length: listaAbas.length,
        child: Scaffold(
          appBar: AppBar(
              title: Text(widget.pet.nome ?? "-"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              bottom: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: listaAbas,
              )),
          body: TabBarView(
            children: [
              PaginaPetInfo(pet: widget.pet),
              PaginaPetVacinas(pet: widget.pet),
              PaginaPetParasitas(pet: widget.pet),
              PaginaPetAtendimento(),
            ],
          ),
        ),
      ),
    );
  }
}
