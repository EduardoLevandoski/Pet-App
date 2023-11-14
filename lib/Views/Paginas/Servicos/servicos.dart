import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Agendamento.dart';
import 'package:pet_app/Models/Atendimento.dart';
import 'package:pet_app/Models/Clinica.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Models/Servico.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/ViewModels/AgendamentoCRUD.dart';
import 'package:pet_app/ViewModels/AtendimentoCRUD.dart';
import 'package:pet_app/ViewModels/PetCRUD.dart';
import 'package:pet_app/ViewModels/ServicoCRUD.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaginaServicos extends StatefulWidget {
  Clinica clinica;

  PaginaServicos({super.key, required this.clinica});

  @override
  State<PaginaServicos> createState() => _PaginaServicosState();
}

class _PaginaServicosState extends State<PaginaServicos> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final ServicoFB _servico = Get.put(ServicoFB());
  final AgendamentoFB _agendamento = Get.put(AgendamentoFB());
  final AtendimentoFB _atendimento = Get.put(AtendimentoFB());
  final PetFB _pet = Get.put(PetFB());

  List<Pet> listaPets = [];
  Pet? pet;
  User? user;

  List<Servico> listaServicos = [];
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
    CarregaServicos();
  }

  CarregaServicos() async {
    setState(() {
      bCarregando = true;
    });

    user = await _auth.getUsuarioAtual();

    listaServicos = await _servico.buscaServicosPorClinicaFB(widget.clinica.id!);
    listaPets = await _pet.buscaPetsPorUIDFB(idUsuario: user!.uid);

    for (Servico servico in listaServicos) {
      if (servico.imgNome != null) {
        servico.imgUrl = await _storage.downloadURL(fileNome: servico.imgNome!, nomeStorageFB: NomesStorageFB.servicos);
      }
    }

    pet = listaPets.first;

    setState(() {
      bCarregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size(0.0, 80.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 16.0),
              child: Text(
                widget.clinica.nomeFantasia ?? "Clínica",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: bCarregando
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SkeletonCarroselServicos(),
                  ],
                ),
              )
            : listaServicos.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        widgetCarroselServicos(),
                      ],
                    ),
                  )
                : const Center(
                    child: Text("Nenhum serviço encontrado."),
                  ));
  }

  Widget widgetCarroselServicos() {
    double altura = 360.0;
    double largura = 220.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            "Serviços",
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: altura,
          child: ListView.builder(
            itemCount: listaServicos.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  CardServico(index, largura),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget CardServico(int index, double largura) {
    return Container(
      padding: const EdgeInsets.only(right: 4.0),
      width: largura,
      child: SizedBox(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 3.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: corCinza,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: listaServicos[index].imgUrl != null
                      ? SizedBox(
                          child: Image.network(
                            listaServicos[index].imgUrl!,
                            width: largura,
                            height: 130,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Skeletonizer(
                                enabled: true,
                                effect: ShimmerEffect(baseColor: corCinza),
                                child: Skeleton.replace(
                                  width: largura,
                                  height: 130,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                                    child: Image.network(
                                      "",
                                      width: largura,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          height: 130,
                          color: corCinza,
                          child: const Center(
                              child: Icon(
                            Icons.photo,
                            size: 35,
                            color: Colors.grey,
                          ))),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 9, 12, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      listaServicos[index].descricao ?? "-",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            "\$ • ${widget.clinica.nomeFantasia}",
                            maxLines: 2,
                            style: const TextStyle(fontSize: 12.0),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(),
                    const SizedBox(height: 5.0),
                    const Text(
                      "Horários disponíveis",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 26,
                      child: ListView.builder(
                        itemCount: listaServicos[index].datasDisponiveis?.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int indexData) {
                          return Container(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16.0),
                              onTap: () {
                                setState(() {
                                  listaServicos[index].indexDataSelecionada = indexData;
                                });
                              },
                              child: Ink(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: listaServicos[index].indexDataSelecionada == indexData
                                      ? corSecundaria.withOpacity(0.3)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text(formataDataHora.format(listaServicos[index].datasDisponiveis?[indexData]),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: listaServicos[index].indexDataSelecionada == indexData
                                            ? corSecundaria.withRed(0)
                                            : Colors.grey[600])),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {
                        DialogServico(listaServicos[index], listaPets);
                      },
                      child: Text(
                        "AGENDAR",
                        style: TextStyle(fontWeight: FontWeight.w600, color: corSecundaria, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DialogServico(Servico servico, List<Pet>? listaPets) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(servico.descricao ?? "-"),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text("Selecione um de seus pets"),
                    DropdownPet(listaPets, setStateDialog),
                    const SizedBox(height: 20),
                    const Text("Selecione um dos horários disponíveis"),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 26,
                      width: RetornaLargura(context),
                      child: ListView.builder(
                        itemCount: servico.datasDisponiveis?.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int indexData) {
                          return Container(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16.0),
                              onTap: () {
                                setState(() {
                                  servico.indexDataSelecionada = indexData;
                                });

                                setStateDialog(() {});
                              },
                              child: Ink(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: servico.indexDataSelecionada == indexData
                                      ? corSecundaria.withOpacity(0.3)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text(formataDataHora.format(servico.datasDisponiveis?[indexData]),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: servico.indexDataSelecionada == indexData
                                            ? corSecundaria.withRed(0)
                                            : Colors.grey[600])),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('CANCELAR',
                          style:
                              TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: corPrimaria.withOpacity(0.8))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      child: Text('AGENDAR',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: corSecundaria.withRed(0))),
                      onPressed: () {
                        try {
                          int idAtendimento = DateTime.now().millisecondsSinceEpoch;

                          _atendimento.criaAtendimentoFB(atendimento: Atendimento(
                            id: idAtendimento,
                            idPet: pet!.id,
                            data: servico.datasDisponiveis?[servico.indexDataSelecionada],
                            status: 2,
                            tipo: 3,
                            servico: servico.descricao,
                          ));

                          _agendamento.criaAgendamentoFB(agendamento: Agendamento(
                            id: DateTime.now().millisecondsSinceEpoch,
                            uid: user!.uid,
                            idAtendimento: idAtendimento,
                            idPet: pet!.id,
                            clinicaNome: widget.clinica.nomeFantasia,
                            servicoDesc: servico.descricao,
                            data: servico.datasDisponiveis?[servico.indexDataSelecionada],
                            status: 2,
                          ));
                        } catch (e) {
                          print(e);
                        }

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget DropdownPet(List<Pet>? listaPets, setStateDialog) {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButtonFormField(
            value: pet,
            focusNode: FocusNode(canRequestFocus: false),
            decoration: InputDecoration(
              labelText: "Pet",
              focusColor: Colors.black.withOpacity(0.5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            items: listaPets?.map<DropdownMenuItem<Pet>>((Pet value) {
              return DropdownMenuItem<Pet>(
                value: value,
                child: Text(value.nome!),
              );
            }).toList(),
            onChanged: (Pet? value) {
              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
                pet = value!;
              });

              setStateDialog(() {});
            }),
      ],
    );
  }

  Widget SkeletonCarroselServicos() {
    double altura = 360.0;
    double largura = 220.0;

    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(baseColor: corCinza),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              "Serviços",
              style: TextStyle(fontSize: 22.0),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: altura,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    SkeletonCardServico(index, largura),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget SkeletonCardServico(int index, double largura) {
    return Container(
      padding: const EdgeInsets.only(right: 4.0),
      width: largura,
      child: SizedBox(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 3.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Skeleton.replace(
                width: largura,
                height: 130,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                  child: Image.network(
                    "",
                    width: largura,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 9, 12, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "-------------------",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            "--------------------------------",
                            maxLines: 2,
                            style: TextStyle(fontSize: 12.0),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(),
                    const SizedBox(height: 5.0),
                    const Text(
                      "---------------------",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 26,
                      child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int indexData) {
                          return Container(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Ink(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text("      ",
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "------------------",
                        style: TextStyle(fontWeight: FontWeight.w600, color: corSecundaria, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
