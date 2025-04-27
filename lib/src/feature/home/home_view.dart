import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:quicklens/src/core/widgets/custom_buttom_widget.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButtomWidget(
          onPressed: () {
         Get.find<AuthCrl>().signOut();
          },
          text: "Sign Out",
        ),
      ),
    );
  }
}
