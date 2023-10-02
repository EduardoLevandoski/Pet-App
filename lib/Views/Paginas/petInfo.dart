import 'package:flutter/material.dart';
import 'package:pet_app/Models/Pet.dart';

class PaginaPetInfo extends StatefulWidget {
  Pet pet;

  PaginaPetInfo({super.key, required this.pet});

  @override
  State<PaginaPetInfo> createState() => _PaginaPetInfoState();
}

class _PaginaPetInfoState extends State<PaginaPetInfo> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 6.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                      child: Text(
                        widget.pet.petNome,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    Image.asset(
                      widget.pet.petImgUrl,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 10),
                          LinhaConteudo(sTitulo: "Raça"),
                          const Divider(),
                          LinhaConteudo(sTitulo: "Data de aniversário"),
                          const Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

Widget LinhaConteudo({required String sTitulo, String? sDescricao}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(sTitulo),
      Text(sDescricao ?? "-"),
    ],
  );
}
