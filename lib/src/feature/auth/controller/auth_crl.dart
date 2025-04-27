import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicklens/src/core/config/app_strings.dart';
import 'package:quicklens/src/core/utils/my_aleart_dialog.dart';
import 'package:quicklens/src/feature/auth/model/user_model.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/view/sign_in_view.dart';
import 'package:quicklens/src/feature/business_details/view/business_details_screen.dart';
import 'package:quicklens/src/feature/home/home_view.dart';

class AuthCrl extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  ///----User Model
  UserModel userModel = UserModel(
    id: '',
    email: '',
    password: '',
    cpassword: '',
    firstname: '',
    lastname: '',
  );

  void setEmail(String newVal) {
    userModel.email = newVal;
    update();
  }

  void firstName(String newVal) {
    userModel.firstname = newVal;
    update();
  }

  void lastName(String newVal) {
    userModel.lastname = newVal;
    update();
  }

  void setPassword(String newVal) {
    userModel.password = newVal;
    update();
  }

  void setCPassword(String newVal) {
    userModel.cpassword = newVal;
    update();
  }

  bool isLoading = false;
  void setIsLoading(bool newVal) {
    isLoading = newVal;
    update();
  }

  bool isVisable = true;
  void setIsVisable() {
    isVisable = !isVisable;
    update();
  }

  void clearData() {
    userModel = UserModel(
      id: '',
      email: '',
      password: '',
      cpassword: '',
      firstname: '',
      lastname: '',
    );

    update();
  }

  Future<void> signUp(BuildContext context) async {
    FocusScope.of(context).unfocus();
    signupFormKey.currentState!.save();

    final bool isValid = signupFormKey.currentState!.validate();

    try {
      if (!userModel.email.isEmail) {
        myAleartDialog(context, text: 'Please enter a valid email');
      } else if (userModel.firstname.isEmpty) {
        myAleartDialog(context, text: 'Please enter your first name');
      } else if (userModel.lastname.isEmpty) {
        myAleartDialog(context, text: 'Please enter your last name');
      } else if (userModel.password.length <= 8 &&
          userModel.cpassword.length <= 8) {
        myAleartDialog(context, text: 'Password must be 8 characters at least');
      } else if (userModel.password != userModel.cpassword) {
        myAleartDialog(context, text: 'Passwords do not match');
      } else if (isValid) {
        setIsLoading(true);
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: userModel.email,
              password: userModel.password,
            )
            .then((UserCredential userCedential) {
              userModel.id = userCedential.user!.uid;

              // إضافة البيانات إلى Firestore
              DocumentReference ref = FirebaseFirestore.instance
                  .collection(AppStrings.users) // تأكد من اسم المجموعة
                  .doc(userCedential.user!.uid);

              ref
                  .set(userModel.toMap())
                  .then((val) {
                    log('User data added to Firestore');
                  })
                  .catchError((error) {
                    log('Error adding user data: $error');
                  });

              Route route = MaterialPageRoute(
                builder: (_) => const BusinessDetailsScreen(),
              );

              Navigator.pushReplacement(context, route);

              setIsLoading(false);
            });
      }
    } on FirebaseAuthException catch (e) {
      setIsLoading(false);
      log(e.toString());

      if (e.code == 'weak-password') {
        myAleartDialog(context, text: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        myAleartDialog(
          context,
          text: 'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        myAleartDialog(context, text: 'The email address is badly formatted.');
      } else {
        log(e.toString());
      }
    }
  }

  Future<void> logIn(BuildContext context) async {
    FocusScope.of(context).unfocus();
    loginFormKey.currentState!.save();

    final bool isValid = loginFormKey.currentState!.validate();

    try {
      if (!userModel.email.isEmail) {
        myAleartDialog(context, text: 'Please enter a valid email');
      } else if (userModel.password.length <= 6) {
        myAleartDialog(
          context,
          text: 'Passwords must be 6 characters at least',
        );
      } else if (isValid) {
        setIsLoading(true);

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: userModel.email,
              password: userModel.password,
            )
            .then((UserCredential userCedential) async {
              Route route = MaterialPageRoute(builder: (_) => const HomeView());

              Navigator.pushReplacement(context, route);
              setIsLoading(false);
            });
      }
    } on FirebaseAuthException catch (e) {
      myAleartDialog(context, text: e.toString());
      setIsLoading(false);
      log(e.toString());

      if (e.code == 'weak-password') {
        myAleartDialog(context, text: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        myAleartDialog(
          context,
          text: 'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        myAleartDialog(context, text: 'The email address is badly formatted.');
      } else {
        log(e.toString());
      }
    }
  }
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      clearData(); // تمسح بيانات المستخدم
      Get.offAll(() => const SignInView()); // يرجع على صفحة تسجيل الدخول
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
