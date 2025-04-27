import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicklens/src/core/widgets/custom_buttom_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButtomWidget(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          text: "Sign Out",
        ),
      ),
    );
  }
}
