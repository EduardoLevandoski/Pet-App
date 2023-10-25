import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';

class PaginaPetCadastro extends StatefulWidget {
  Pet? pet;

  PaginaPetCadastro({super.key, this.pet});

  @override
  State<PaginaPetCadastro> createState() => _PaginaPetCadastroState();
}

class _PaginaPetCadastroState extends State<PaginaPetCadastro> with SingleTickerProviderStateMixin {
  final TextEditingController _controladoraNome = TextEditingController();
  final TextEditingController _controladoraIdade = TextEditingController();
  final TextEditingController _controladoraPeso = TextEditingController();
  final TextEditingController _controladoraTutor = TextEditingController();

  List<String> listaSexo = ["Macho", "Fêmea"];
  List<String> listaEspecie = ["Cachorro", "Gato"];
  List<String> listaRaca = ["Vira-lata", "Poddle", "Scottish-Fold"];
  List<String> listaCor = ["Preto", "Branco"];

  String? sexo;
  String? especie;
  String? raca;
  String? cor;

  @override
  void initState() {
    SetaValores();
    super.initState();
  }

  SetaValores() {
    _controladoraNome.text = widget.pet?.petNome ?? "";
    _controladoraIdade.text = widget.pet?.petIdade != null ? "${widget.pet!.petIdade!.month} mêses" : "";
    _controladoraPeso.text = widget.pet?.petPeso ?? "";

    sexo = widget.pet?.petSexo;
    especie = widget.pet?.petEspecie;
    raca = widget.pet?.petRaca;
    cor = widget.pet?.petCor;
  }

  @override
  void dispose() {
    _controladoraNome.dispose();
    _controladoraIdade.dispose();
    _controladoraPeso.dispose();
    _controladoraTutor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: bTecladoAberto(context)
          ? null
          : FloatingActionButton(
              tooltip: widget.pet != null ? "Editar " : "Confirmar",
              onPressed: () {
                Get.back();
              },
              child: const Icon(Icons.check),
            ),
      appBar: AppBarPadrao(sTitulo: "${widget.pet != null ? "Editar " : "Cadastrar"} um Pet"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Digite os dados do seu Pet", style: TextStyle(fontSize: 22.0)),
                  CampoTextField(sLabel: "Nome", controladora: _controladoraNome),
                  CampoTextField(sLabel: "Idade", controladora: _controladoraIdade),
                  DropdownSexo(),
                  DropdownEspecie(),
                  DropdownRaca(),
                  CampoTextField(sLabel: "Peso (Kg)", controladora: _controladoraPeso),
                  DropdownCor(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CampoTextField({required String sLabel, required controladora}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextField(
          autofocus: false,
          controller: controladora,
          decoration: InputDecoration(
            labelText: sLabel,
          ),
        ),
      ],
    );
  }

  Widget DropdownSexo() {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButtonFormField(
            value: sexo,
            decoration: InputDecoration(
              labelText: "Sexo",
              suffixIcon: sexo != null
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          sexo = null;
                        });
                      },
                      icon: const Icon(Icons.clear))
                  : null,
              focusColor: Colors.black.withOpacity(0.5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            items: listaSexo.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                sexo = value!;
              });
            }),
      ],
    );
  }

  Widget DropdownEspecie() {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButtonFormField(
            value: especie,
            decoration: InputDecoration(
              labelText: "Espécie",
              suffixIcon: especie != null
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          especie = null;
                        });
                      },
                      icon: const Icon(Icons.clear))
                  : null,
              focusColor: Colors.black.withOpacity(0.5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            items: listaEspecie.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                especie = value!;
              });
            }),
      ],
    );
  }

  Widget DropdownRaca() {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButtonFormField(
            value: raca,
            decoration: InputDecoration(
              labelText: "Raça",
              suffixIcon: raca != null
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          raca = null;
                        });
                      },
                      icon: const Icon(Icons.clear))
                  : null,
              focusColor: Colors.black.withOpacity(0.5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            items: listaRaca.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                raca = value!;
              });
            }),
      ],
    );
  }

  Widget DropdownCor() {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButtonFormField(
            value: cor,
            decoration: InputDecoration(
              labelText: "Cor",
              suffixIcon: cor != null
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          cor = null;
                        });
                      },
                      icon: const Icon(Icons.clear))
                  : null,
              focusColor: Colors.black.withOpacity(0.5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            items: listaCor.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                cor = value!;
              });
            }),
      ],
    );
  }
}
