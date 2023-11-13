import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_bottomNavigationBar.dart';
import 'package:pet_app/ViewModels/AgendamentoCRUD.dart';
import 'package:pet_app/ViewModels/PetCRUD.dart';
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
  final AgendamentoFB _agendamento = Get.put(AgendamentoFB());
  final PetFB _pet = Get.put(PetFB());
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
              actions: [IconButton(onPressed: () {
                try {
                  AlertaSimOuNao(
                      context: context,
                      sTitulo: "Atenção",
                      sConteudo:
                      "Tem certeza que deseja remover o pet?",
                      onPressedSim: () async {

                        _agendamento.removeAgendamentoPet(petId: widget.pet.id!);
                        _pet.removePet(id: widget.pet.id!);

                        Get.offAll(() => utilBottomNavigationBar());
                      },
                      onPressedNao: () {
                        Get.back();
                      });
                } catch (e) {
                  Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
                }
              }, icon: const Icon(Icons.delete))],
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
