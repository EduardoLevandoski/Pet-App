import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Models/Pet.dart';
import 'package:pet_app/Views/Paginas/pet.dart';

class PaginaPets extends StatefulWidget {
  const PaginaPets({super.key});

  @override
  State<PaginaPets> createState() => _PaginaPetsState();
}

class _PaginaPetsState extends State<PaginaPets> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<Pet> listaPets = [
    Pet(
        petCod: 1,
        petNome: "Pedro",
        petRaca: "Vira-lata",
        petImgUrl: "assets/examples/dog-1.jpg",
        petIdade: DateTime(2002, 4, 12),
        petSexo: "Macho"),
    Pet(
        petCod: 2,
        petNome: "Márcio",
        petRaca: "Poddle",
        petImgUrl: "assets/examples/dog-5.jpg",
        petIdade: DateTime(2002, 2, 24),
        petSexo: "Macho"),
    Pet(
        petCod: 3,
        petNome: "Pedro",
        petRaca: "Scottish-Fold",
        petImgUrl: "assets/examples/cat-2.jpg",
        petIdade: DateTime(2002, 5, 23),
        petSexo: "Macho"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Cadastrar um pet",
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.63,
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 80),
        children: List.generate(listaPets.length, (index) {
          return CardPet(pet: listaPets[index]);
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
      borderRadius: BorderRadius.circular(8.0),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 3.0,
    child: InkWell(
      onTap: () {
        Get.to(() => PaginaPet(pet: pet));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image(
              image: AssetImage(pet.petImgUrl ?? ""),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 9, 12, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pet.petNome,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  pet.petRaca ?? "-",
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
                      pet.petIdade != null ? "${pet.petIdade!.month} mêses" : "-",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      pet.petSexo ?? "-",
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
