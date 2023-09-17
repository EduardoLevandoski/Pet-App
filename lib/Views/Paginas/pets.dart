import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Utils/util.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/Paginas/pet.dart';

class PaginaPets extends StatefulWidget {
  const PaginaPets({super.key});

  @override
  State<PaginaPets> createState() => _PaginaPetsState();
}

class _PaginaPetsState extends State<PaginaPets>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<Pet> listaPets = [
    Pet(1, "Pedro", "assets/examples/dog-1.jpg"),
    Pet(2, "Márcio", "assets/examples/dog-5.jpg"),
    Pet(3, "Mila", "assets/examples/cat-2.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPadrao(sTitulo: "Pets"),
      floatingActionButton: FloatingActionButton(
        tooltip: "Cadastrar um pet",
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 80),
        children: List.generate(3, (index) {
          return CardPet(
              pet: listaPets[index]);
        }),
      ),
    );
  }
}

Widget CardPet({
  required Pet pet,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: InkWell(
      onTap: () {
        Get.to(PaginaPet(pet: pet));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Ink.image(
            image: AssetImage(pet.petImgUrl),
            height: 120,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pet.petNome,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
