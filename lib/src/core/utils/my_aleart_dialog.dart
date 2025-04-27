import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklens/src/core/widgets/custom_buttom_widget.dart';

void myAleartDialog(BuildContext context, {String text = ''}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 25.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          CustomButtomWidget(
          
            text: 'ok',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
