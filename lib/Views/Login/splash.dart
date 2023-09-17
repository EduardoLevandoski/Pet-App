import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/Views/Login/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController controladoraAnimacao;

  @override
  void initState() {
    super.initState();
    controladoraAnimacao = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controladoraAnimacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset('assets/splashart.json',
                    controller: controladoraAnimacao, onLoaded: (value) {
                  controladoraAnimacao.addStatusListener((status) async {
                    if (status == AnimationStatus.completed) {
                      await Get.offAll(const Login());
                    }
                  });

                  controladoraAnimacao.duration = value.duration;
                  controladoraAnimacao.forward();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
