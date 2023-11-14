import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Agendamento.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Utils/util_globals.dart';
import 'package:pet_app/ViewModels/AgendamentoCRUD.dart';
import 'package:pet_app/ViewModels/PetCRUD.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';
import 'package:pet_app/Views/Paginas/Pet/pet.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> with SingleTickerProviderStateMixin {
  utilGlobal global = Get.find<utilGlobal>();
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final AgendamentoFB _agendamento = Get.put(AgendamentoFB());
  final PetFB _pet = Get.put(PetFB());

  List<Agendamento> listaAgendamentos = [];
  List<Pet> listaPets = [];

  bool bCarregaListas = false;
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
    CarregaDados();
  }

  CarregaDados() async {
    setState(() {
      bCarregando = true;
    });

    User? user = await _auth.getUsuarioAtual();

    await Future.delayed(const Duration(milliseconds: 500), () async {
      listaAgendamentos = await _agendamento.buscaAgendamentosPorUIDFB(user!.uid);
    });

    for (Agendamento agendamento in listaAgendamentos) {
      agendamento.pet = await _pet.buscaPetPorID(id: agendamento.idPet!);

      if (agendamento.pet!.imgNome != null) {
        agendamento.pet!.imgUrl =
            await _storage.downloadURL(fileNome: agendamento.pet!.imgNome!, nomeStorageFB: NomesStorageFB.pets);
      }
    }

    await Future.delayed(const Duration(milliseconds: 500), () async {
      listaPets = await _pet.buscaPetsPorUIDFB(idUsuario: user!.uid);
    });

    for (Pet pet in listaPets) {
      if (pet.imgNome != null) {
        pet.imgUrl = await _storage.downloadURL(fileNome: pet.imgNome!, nomeStorageFB: NomesStorageFB.pets);
      }
    }

    if (listaAgendamentos.isNotEmpty || listaPets.isNotEmpty) {
      bCarregaListas = true;
    }

    setState(() {
      bCarregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bCarregando
          ? Column(
              children: [
                SkeletonCardMenuPrincipal(),
                SkeletonCardMenuPrincipal(),
                const SizedBox(height: 80),
              ],
            )
          : SingleChildScrollView(
              child: bCarregaListas
                  ? Column(
                      children: [
                        if (listaAgendamentos.isNotEmpty) widgetCarroselAgendamentos(),
                        if (listaPets.isNotEmpty) widgetCarroselPets(),
                      ],
                    )
                  : Column(
                      children: [
                        CardMenuPrincipal(
                            sTitulo: "Pets",
                            sDescricao: "Vizualizar, editar ou cadastrar seus pets.",
                            urlImagem: "assets/images/pets.jpg",
                            paginaIndex: 1),
                        CardMenuPrincipal(
                            sTitulo: "Serviços",
                            sDescricao: "Solicitar serviços para seus pets.",
                            urlImagem: "assets/images/pet-service.jpg",
                            paginaIndex: 2),
                        const SizedBox(height: 80),
                      ],
                    ),
            ),
    );
  }

  Widget CardMenuPrincipal({
    required String sTitulo,
    required String sDescricao,
    required String urlImagem,
    int? paginaIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 6.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3.0,
        child: InkWell(
          onTap: () {
            if (paginaIndex != null) {
              global.updateBottomNavigationBarIndex(paginaIndex);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Ink.image(
                image: AssetImage(urlImagem),
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      sTitulo,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      sDescricao,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetCarroselAgendamentos() {
    double altura = 200.0;
    double largura = 320.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            "Agendamentos",
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: altura,
          child: ListView.builder(
            itemCount: listaAgendamentos.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  CardAgendamento(index, largura),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget CardAgendamento(int index, double largura) {
    Color cardCor;

    if (index % 3 == 0) {
      cardCor = const Color(0xffD4E2D4);
    } else if (index % 2 == 0) {
      cardCor = const Color(0xffFFCACC);
    } else {
      cardCor = const Color(0xffDBC4F0);
    }

    return Container(
      padding: const EdgeInsets.only(right: 4.0),
      width: largura,
      child: SizedBox(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          color: cardCor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 3.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(12, 9, 16, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listaAgendamentos[index].servicoDesc ?? "-",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    Text(
                      listaAgendamentos[index].clinicaNome ?? "-",
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (listaAgendamentos[index].pet!.imgUrl != null)
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: corCinza,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        listaAgendamentos[index].pet!.imgUrl!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ),
                            const SizedBox(width: 10),
                            Text(
                              listaAgendamentos[index].pet!.nome ?? "-",
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        (((listaAgendamentos[index].status ?? 2) != 2))
                            ? RetornaStatus(listaAgendamentos[index].status!)
                            : Text(
                                listaAgendamentos[index].data != null
                                    ? ("Às ${formataDataHora.format(listaAgendamentos[index].data!)}")
                                    : "__:__",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
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
  }

  Widget widgetCarroselPets() {
    double altura = 300.0;
    double largura = 200.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            "Pets",
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: altura,
          child: ListView.builder(
            itemCount: listaPets.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  CardPet(index, largura),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget CardPet(
    int index,
    double largura,
  ) {
    return Container(
      padding: const EdgeInsets.only(right: 4.0),
      width: largura,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3.0,
        child: InkWell(
          onTap: () {
            Get.to(() => PaginaPet(pet: listaPets[index]))?.then((value) {
              if (value ?? false) {
                CarregaDados();
              }
            });
          },
          child: Ink(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: corCinza,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                    child: listaPets[index].imgUrl != null
                        ? SizedBox(
                            child: Image.network(
                              listaPets[index].imgUrl!,
                              width: largura,
                              height: 175,
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
                                    height: 175,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                                      child: Image.network(
                                        "",
                                        width: largura,
                                        height: 175,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            height: 175,
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
                        listaPets[index].nome!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        listaPets[index].raca ?? "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            listaPets[index].idade != null ? retornaIdade(listaPets[index].idade!) : "-",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            listaPets[index].sexo ?? "-",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      )
                      //const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SkeletonCardMenuPrincipal() {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(baseColor: corCinza),
      child: Padding(
        padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 6.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 3.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Skeleton.replace(
                height: 160,
                width: RetornaLargura(context),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                  child: Image.network(
                    "",
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "--------------",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      "-------------------------------------------------",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
