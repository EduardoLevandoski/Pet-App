import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_bottomNavigationBar.dart';
import 'package:pet_app/Utils/util_constantes.dart';
import 'package:pet_app/ViewModels/PetCRUD.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';

class PaginaPetCadastro extends StatefulWidget {
  Pet? pet;

  PaginaPetCadastro({super.key, this.pet});

  @override
  State<PaginaPetCadastro> createState() => _PaginaPetCadastroState();
}

class _PaginaPetCadastroState extends State<PaginaPetCadastro> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final PetFB _pet = Get.put(PetFB());

  final TextEditingController _controladoraNome = TextEditingController();
  final TextEditingController _controladoraIdade = TextEditingController();
  final TextEditingController _controladoraPeso = TextEditingController();
  final TextEditingController _controladoraTutor = TextEditingController();
  final TextEditingController _controladoraFotoNome = TextEditingController();

  DateTime? data;
  String? sexo;
  String? especie;
  String? raca;

  String? filePath;
  String? fileNome;

  bool bCarregando = false;

  @override
  void initState() {
    SetaValores();
    super.initState();
  }

  SetaValores() {
    _controladoraNome.text = widget.pet?.nome ?? "";
    _controladoraIdade.text = widget.pet?.idade != null ? formataData.format(widget.pet!.idade!) : "";
    _controladoraPeso.text = widget.pet?.peso.toString() ?? "";
    _controladoraFotoNome.text = widget.pet?.imgNome ?? "";

    sexo = widget.pet?.sexo;
    especie = widget.pet?.especie;
    raca = widget.pet?.raca;
    data = widget.pet?.idade;
  }

  @override
  void dispose() {
    _controladoraNome.dispose();
    _controladoraIdade.dispose();
    _controladoraPeso.dispose();
    _controladoraTutor.dispose();
    _controladoraFotoNome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: bTecladoAberto(context)
          ? null
          : FloatingActionButton(
              tooltip: widget.pet != null ? "Editar " : "Confirmar",
              onPressed: bCarregando
                  ? null
                  : () {
                      cadastrarPet();
                    },
              child: bCarregando ? CircularProgressPadrao(dTamanho: 30) : const Icon(Icons.check),
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
                  DropdownEspecie(),
                  DropdownRaca(),
                  CampoData(sLabel: "Data/Ano de Nascimento", controladora: _controladoraIdade),
                  Row(
                    children: [
                      Expanded(child: CampoTextField(sLabel: "Peso (Kg)", controladora: _controladoraPeso)),
                      const SizedBox(width: 10),
                      Expanded(child: DropdownSexo()),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(height: 25),
                  CampoFoto(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CampoFoto() {
    return Column(
      children: [
        const SizedBox(height: 5),
        TextFormField(
          autofocus: false,
          canRequestFocus: false,
          readOnly: true,
          controller: _controladoraFotoNome,
          decoration: InputDecoration(
            labelText: "Foto",
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      final pick = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 30);

                      if (pick != null) {
                        filePath = pick.path;
                        fileNome = pick.name;

                        _controladoraFotoNome.text = pick.name;
                      }

                      setState(() {});
                    },
                    icon: const Icon(Icons.camera_alt)),
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () async {
                      final pick = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 30);

                      if (pick != null) {
                        filePath = pick.path;
                        fileNome = pick.name;

                        _controladoraFotoNome.text = pick.name;
                      }

                      setState(() {});
                    },
                    icon: const Icon(Icons.attach_file)),
              ],
            ),
          ),
        ),
      ],
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

  Widget CampoData({required String sLabel, required controladora}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextField(
          autofocus: false,
          canRequestFocus: false,
          readOnly: true,
          controller: controladora,
          decoration: InputDecoration(
              labelText: sLabel,
              suffixIcon: IconButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    data = pickedDate;

                    setState(() {
                      controladora.text = formataData.format(data!);
                    });
                  }
                },
                icon: const Icon(Icons.date_range),
              )),
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
            focusNode: FocusNode(canRequestFocus: false),
            decoration: InputDecoration(
              labelText: "Sexo",
              suffixIcon: sexo != null
                  ? IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
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
              FocusScope.of(context).requestFocus(FocusNode());
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
            focusNode: FocusNode(canRequestFocus: false),
            decoration: InputDecoration(
              labelText: "Espécie",
              suffixIcon: especie != null
                  ? IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
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
                FocusScope.of(context).requestFocus(FocusNode());
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
            focusNode: FocusNode(canRequestFocus: false),
            decoration: InputDecoration(
              labelText: "Raça",
              suffixIcon: raca != null
                  ? IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
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
                FocusScope.of(context).requestFocus(FocusNode());
                raca = value!;
              });
            }),
      ],
    );
  }

  void cadastrarPet() async {
    try {
      GetAlertaSimOuNao(
          sTitulo: "Confirmar",
          sConteudo: "Deseja realizar o cadastro do pet?",
          onPressedSim: () async {
            Get.back();

            setState(() {
              bCarregando = true;
            });

            User? user = await _auth.getUsuarioAtual();
            String? fileStorage;

            if (user != null) {
              if (filePath != null && fileNome != null) {
                fileStorage = "${formataDataComleta.format(DateTime.now())}_${fileNome!}";

                await _storage.enviaArquivo(filePath: filePath!, fileNome: fileStorage, nomeStorageFB: NomesStorageFB.pets);
              } else if (widget.pet?.imgNome != null && widget.pet?.imgUrl != null) {
                await _storage.editaAqruivo(fileUrl: widget.pet!.imgUrl!, fileNome: widget.pet!.imgNome!, nomeStorageFB: NomesStorageFB.pets);
              }

              if (widget.pet != null) {
                _pet.editaPet(
                    id: widget.pet!.id!,
                    pet: Pet(
                      id: DateTime.now().millisecondsSinceEpoch,
                      uid: user.uid,
                      nome: _controladoraNome.text,
                      idade: data,
                      sexo: sexo,
                      especie: especie,
                      raca: raca,
                      peso: _controladoraPeso.text.isNotEmpty ? double.tryParse(_controladoraPeso.text) : null,
                      imgNome: widget.pet!.imgNome,
                    ));
              } else {
                _pet.criaPetFB(
                    pet: Pet(
                  id: DateTime.now().millisecondsSinceEpoch,
                  uid: user.uid,
                  nome: _controladoraNome.text,
                  idade: data,
                  sexo: sexo,
                  especie: especie,
                  raca: raca,
                  peso: _controladoraPeso.text.isNotEmpty ? double.tryParse(_controladoraPeso.text) : null,
                  imgNome: fileStorage,
                ));
              }

              Get.offAll(() => utilBottomNavigationBar());
              setState(() {
                bCarregando = false;
              });
            } else {
              throw ("Não foi realizar o cadastro do pet, pois o seu usuário não pode ser encontrado, realize o login novamente ou tente de novo mais tarde");
            }
          },
          onPressedNao: () {
            Get.back();
          });
    } catch (e) {
      Get.snackbar("Erro", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
      setState(() {
        bCarregando = false;
      });
    }
  }
}
