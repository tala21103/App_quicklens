import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quicklens/app_quicklens.dart';
import 'package:quicklens/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(AppQuicklens());
}

