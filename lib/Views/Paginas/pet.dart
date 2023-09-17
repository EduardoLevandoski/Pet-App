import 'package:flutter/material.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/Paginas/petInfo.dart';

class PaginaPet extends StatefulWidget {
  Pet pet;

  PaginaPet({super.key, required this.pet});

  @override
  State<PaginaPet> createState() => _PaginaPetState();
}

class _PaginaPetState extends State<PaginaPet>
    with SingleTickerProviderStateMixin {
  List<Tab> listaAbas = [
    const Tab(text: "INFO"),
    const Tab(text: "ATENDIMENTOS"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: listaAbas.length,
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.pet.petNome),
            bottom: TabBar(
              tabs: listaAbas,
            )),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            PaginaPetInfo(pet: widget.pet),
            Container(),
          ],
        ),
      ),
    );
  }
}
