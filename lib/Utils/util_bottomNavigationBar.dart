import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/Paginas/perfil.dart';
import 'package:pet_app/Views/Paginas/pets.dart';
import 'package:pet_app/Views/Paginas/servicos.dart';
import 'package:pet_app/Views/principal.dart';

import 'util_globals.dart';

class utilBottomNavigationBar extends StatefulWidget {
  utilBottomNavigationBar({super.key});

  @override
  State<utilBottomNavigationBar> createState() => _utilBottomNavigationBarState();
}

class _utilBottomNavigationBarState extends State<utilBottomNavigationBar> {
  utilGlobal global = Get.find<utilGlobal>();

  static final List<Widget> _widgetOptions = <Widget>[
    const Principal(),
    const PaginaPets(),
    const PaginaServicos(),
    PaginaPerfil(),
  ];

  atualizaIndexNavigation(int index) {
    global.updateBottomNavigationBarIndex(index);
  }

  void _onItemTapped(int index) {
    setState(() {
      global.updateBottomNavigationBarIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(global.bottomNavigationBarIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Principal',
              backgroundColor: corPrimaria,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pets),
              label: 'Pets',
              backgroundColor: corPrimaria,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bathtub),
              label: 'Serviços',
              backgroundColor: corPrimaria,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Perfil',
              backgroundColor: corPrimaria,
            ),
          ],
          currentIndex: global.bottomNavigationBarIndex.value,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
