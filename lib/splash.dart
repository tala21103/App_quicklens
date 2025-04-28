import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:quicklenc/item_grid_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
    children: [
      // Positioned.fill(child: Image.asset(
      //   "assets/images/splashscreen.png",
      //   fit: BoxFit.cover,),),
      const Positioned.fill(child: Scaffold()
      ,),
        AnimatedSplashScreen(
          splash: Image.asset("assets/images/quickgif.gif"),
          nextScreen: const ItemGridScreen(),
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent,),
    ],
    );
  }

}

