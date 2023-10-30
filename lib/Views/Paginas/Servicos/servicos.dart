import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(child: Text("Nenhuma empresa encontrada.")),
    );
  }
}
