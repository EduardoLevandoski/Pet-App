import 'package:get/get.dart';

class utilGlobal extends GetxController {
  RxInt bottomNavigationBarIndex = 0.obs;

  updateBottomNavigationBarIndex(int index){
    bottomNavigationBarIndex(index);
  }
}