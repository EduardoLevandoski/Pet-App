import 'package:flutter/material.dart';

class PaginaPetAtendimento extends StatefulWidget {
  const PaginaPetAtendimento({super.key});

  @override
  State<PaginaPetAtendimento> createState() => _PaginaPetAtendimentoState();
}

class _PaginaPetAtendimentoState extends State<PaginaPetAtendimento> with SingleTickerProviderStateMixin {

  List<int> listaPetAtendimentos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listaPetAtendimentos.isNotEmpty ? ListView.builder(
        itemCount: 0,
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Container(
              padding: const EdgeInsets.all(12),
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
                          Text("Serviço"),
                          Text("-"),
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
                                  Text("Valor"),
                                  Text("-"),
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
        },
      ) : const Center(child: Text("Nenhum atendimento encontrado.")),
    );
  }
}
