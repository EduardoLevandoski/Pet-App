import 'package:flutter/material.dart';
import 'package:pet_app/Utils/util.dart';

class PaginaServicos extends StatefulWidget {
  const PaginaServicos({super.key});

  @override
  State<PaginaServicos> createState() => _PaginaServicosState();
}

class _PaginaServicosState extends State<PaginaServicos> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPadrao(sTitulo: "Serviços"),
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
