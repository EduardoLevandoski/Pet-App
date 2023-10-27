import 'package:get/get.dart';

class utilGlobal extends GetxController {
  static utilGlobal get instance => Get.find();
  RxInt bottomNavigationBarIndex = 0.obs;

  updateBottomNavigationBarIndex(int index){
    bottomNavigationBarIndex(index);
  }
}