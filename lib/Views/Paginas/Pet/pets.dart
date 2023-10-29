import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Services/auth_service.dart';
import 'package:pet_app/Services/storage_service.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/ViewModels/PetCRUD.dart';
import 'package:pet_app/ViewModels/constantesFB.dart';
import 'package:pet_app/Views/Paginas/Pet/pet.dart';
import 'package:pet_app/Views/Paginas/Pet/petCadastro.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaginaPets extends StatefulWidget {
  const PaginaPets({super.key});

  @override
  State<PaginaPets> createState() => _PaginaPetsState();
}

class _PaginaPetsState extends State<PaginaPets> with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = Get.put(FirebaseAuthService());
  final FirebaseStorageService _storage = Get.put(FirebaseStorageService());
  final PetFB _pet = Get.put(PetFB());

  List<Pet> listaPets = [];
  bool bCarregando = false;

  @override
  void initState() {
    super.initState();
    CarregaPets();
  }

  CarregaPets() async {
    setState(() {
      bCarregando = true;
    });

    User? user = await _auth.getUsuarioAtual();

    if (user != null) {
      listaPets = await _pet.buscaPetsPorUIDFB(idUsuario: user.uid);

      for (Pet pet in listaPets) {
        if (pet.imgNome != null) {
          pet.imgUrl = await _storage.downloadURL(fileNome: pet.imgNome!, nomeStorageFB: NomesStorageFB.pets);
        }
      }
    }

    setState(() {
      bCarregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Cadastrar um pet",
        onPressed: () {
          Get.to(() => PaginaPetCadastro())?.then((value) {
            if(value ?? false) {
              CarregaPets();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: bCarregando
          ? GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.63,
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 80),
              children: List.generate(4, (index) {
                return Skeletonizer(
                  enabled: true,
                  effect: ShimmerEffect(baseColor: corCinza),
                  child: SkeletonCard(),
                );
              }),
            )
          : listaPets.isNotEmpty ? GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.63,
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 80),
              children: List.generate(listaPets.length, (index) {
                return CardPet(pet: listaPets[index]);
              }),
            ) : const Center(child: Text("Nenhum pet encontrado.")),
    );
  }

  Widget CardPet({
    required Pet pet,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      child: InkWell(
        onTap: () {
          Get.to(() => PaginaPet(pet: pet))?.then((value) {
            if(value ?? false) {
              CarregaPets();
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: corCinza,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: pet.imgUrl != null
                    ? Image.network(
                        pet.imgUrl!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Skeletonizer(
                      enabled: true,
                      effect: ShimmerEffect(baseColor: corCinza),
                      child: Skeleton.replace(
                        width: 200,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "",
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                      )
                    : Container(
                        height: 200,
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
                    pet.nome!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    pet.raca ?? "-",
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
                        pet.idade != null ? retornaIdade(pet.idade!) : "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        pet.sexo ?? "-",
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
    );
  }


  Widget SkeletonCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Skeleton.replace(
            width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 9, 12, 2),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "",
                ),
                Text(
                  "",
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                    ),
                    Text(
                      "",
                    ),
                  ],
                )
                //const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
