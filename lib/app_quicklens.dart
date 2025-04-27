import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quicklens/src/core/config/bindings.dart';
import 'package:quicklens/src/feature/pages_start/init_start_view.dart';

class AppQuicklens extends StatelessWidget {
  const AppQuicklens({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: MyBindings(),
          home: child,
        );
      },
      child: const InitStartView(),
    );
  }
}
